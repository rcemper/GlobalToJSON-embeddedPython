Class dc.GblToJSON.E
{

ClassMethod do(gref As %String = "^%") As %DynamicObject
{
	new %gref
	set %gref=gref
	set json={}
	if $d(@%gref) set json=..json()
	quit json
}

ClassMethod json(json = "") As %DynamicObject
{
	set json={}
	set json.gbl=[]
	set node=..node()
	do json.gbl.%Push(node)	
	for  {
		set node=$q(@$ZR) quit:node=""
		set node=..node()
		do json.gbl.%Push(node)
		}
	quit json
}

ClassMethod node() As %DynamicObject
{
	set d=$d(@$ZR,val)
	set node={}
	if d set node.node=$ZR
	if d#2 {
		if $lv(val) set val=..lb(val)
		set node.val=val 
		}
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

ClassMethod load(json As %DynamicObject) As %Status
{
	new %node
	set gbl=json.gbl
	set sc=0
	if gbl.%IsA("%Library.DynamicArray") {
		set iter=gbl.%GetIterator()
		while iter.%GetNext(.key , .obj ) { 
			if obj.%IsA("%Library.DynamicObject") {
				set %node=obj.node
				set val=obj.val
				if $e(val,1,4)="$lb(" {
					set %node=%node_"="_val
					set @%node
				} else  {
					set @%node=val 
					}  
				}
			}
		set sc=1
		}
	quit sc
}

}
