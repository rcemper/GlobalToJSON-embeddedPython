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
	new %zr
	set %zr=$ZR
	open 2:$$$topspool use 2 zwrite val close 2
	set lb=$e($tr(^SPOOL($$$topspool,1),$c(27,13,10)_"[12m"),5,*)
	if $d(@%zr)
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
