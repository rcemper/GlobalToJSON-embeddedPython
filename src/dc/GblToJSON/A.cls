Class dc.GblToJSON.A
{

ClassMethod do(gref As %String = "^%") As %DynamicObject
{
	new %gref
	set %gref=gref
	set json={}
	if $d(@%gref) set json=..node()
	quit json
}

ClassMethod node(d = "") As %DynamicObject
{
	set d=$d(@$ZR,val)
	set node={}
	if d set node.node=$QS($zr,$Ql($zr))
	if d#2 {
		if $lv(val) set val=..lb(val)
		set node.val=val 
		}
 	if d>2 {
	 	new %zo,%zr
	 	set node.sub=[]
	 	set %zo=""
	 	set %zr=$ZR
	 	for  { 
	 		set %zo=$o(@%zr@(%zo))
			quit:%zo=""
		 	set sub=..node()
			do node.sub.%Push(sub)
	 	}}
	 quit node
}

ClassMethod lb(val = "") As %String
{
#define topspool 99999
	new %zsp
	set %zsp=$zr
	open 2:$$$topspool use 2 zwrite val close 2
	set lb=^SPOOL($$$topspool,1)
	set lb=$replace(lb,$c(27)_"[22m","")
	set lb=$replace(lb,$c(27)_"[1m","")
	set lb=$tr(lb,$c(13,10))
	set lb=$e(lb,5,*)
	if $d(@%zsp)
	quit lb
}

ClassMethod load(obj As %DynamicObject) As %Status
{
#;	new %node
	set sc=0
	set sub=obj.sub
	set node=obj.node
	set type=obj.%GetTypeOf("val")
	do ..set(node,obj.val,type)
	if sub.%IsA("%Library.DynamicArray") {
		set node=node_"("
		do ..sub(node,sub)
		set sc=$$$OK 
		}
	quit sc
}

ClassMethod set(
	%node,
	val,
	type)
{
	if type="unassigned" quit
	if "array,object"[type {
		set %node=%node_"="_val_".%ToJSON()"
		}
	elseif (type="number") {
		set %node=%node_"="_val
		}
	elseif type="string" {
		if ($e(val,1,4)="$lb(") {
			set %node=%node_"="_val
			}
		elseif ("{"=($e(val))&&("}"=$e(val,*)))||("["=($e(val))&&("]"=$e(val,*))) {
			set %node=%node_"="_val_".%ToJSON()"
			} 	
		else {
			set %node=%node_"="""_val_""""
			}
	}
	else { quit }
	set @%node
}

ClassMethod sub(
	level,
	gbl As %DynamicArray) As %Status
{
	set iter=gbl.%GetIterator()
	while iter.%GetNext(.key , .obj ) {
		 
		if obj.%IsA("%Library.DynamicObject") {
			set ono=obj.node
			if '$isvalidnum(ono) set ono=""""_ono_""""
			set node=level_ono 
			set type=obj.%GetTypeOf("val")
			do ..set(node_")",obj.val,type)
			set sub=obj.sub
			if obj.%GetTypeOf("sub")="array" {
				do ..sub(node_",",sub)
				}
			}
		}
	set sc=1
	
	quit sc
}

}
