Class dc.GblToJSON.ePy
{

ClassMethod do(
	gref As %String = "^%",
	file = "gbl.json") As %Status
{
	new %gref
	set %gref=gref
	set d=$d(@%gref,val) 
	if 'd quit d
	set pyFile=..init(file)
	if d#2 set sc=..py(%gref,val,pyFile)
	for i=1:1 {
		set %gref=$q(@%gref,1,val)
		if %gref="" quit
		if $lv(val) set val=..lb(val)
		set sc=..py(%gref,val,pyFile)
		}
	set sc=..done(pyFile)
	quit $$$OK
}

ClassMethod init(file As %String) As %SYS.Python [ Language = python ]
{
fil=open(file,'w')
fil.write('{"gbl":[\n')
return fil
}

ClassMethod py(
	node As %String,
	val As %String,
	fil As %SYS.Python) As %Status [ Language = python ]
{
import json
gn={}	
gn["node"]=node
gn["val"]=val
fil.writelines([json.dumps(gn),'\n'])
return 1
}

ClassMethod done(fil As %SYS.Python) As %Status [ Language = python ]
{
fil.write(']}')
fil.close()
return 1
}

ClassMethod lb(val = "") As %String
{
#define topspool 99999
	open 2:$$$topspool use 2 zwrite val close 2
	set lb=^SPOOL($$$topspool,1)
	set lb=$replace(lb,$c(27)_"[22m","")
	set lb=$replace(lb,$c(27)_"[1m","")
	set lb=$tr(lb,$c(13,10))
	set lb=$e(lb,5,*)
	quit lb
}

ClassMethod setLb(
	gbl,
	val)
{
	new %gref
	set %gref=gbl_"="_val
	set @%gref
	quit $$$OK
}

ClassMethod load(file = "gbl.json") As %Status
{
	set clsn=$this
	quit ..loadPy(file,clsn)
}

ClassMethod loadPy(
	file As %String,
	clsn As %String) As %Status [ Language = python ]
{
import json
import iris

cls=iris.cls(clsn)
g=""

with open(file,'r') as fil:
	for lin in fil:
		if lin == ']}': 
			break
		lin=lin[:-1]	
		if lin == '{"gbl":[' :
			continue
#;		print('\t',lin)
		jsn=json.loads(lin)
#;		print(jsn)
		node=str(jsn["node"])
		val=str(jsn["val"])
		if val[:4] == '$lb(':
			sc = cls.setLb(node,val)
			continue
			
		gbl=node.partition('(')[0]
		sbs=node[:-1].partition(gbl+'(')[2]
		sub=sbs.replace('"','').split(',')
#;		print('gbl:',gbl,'\nsbs:',sbs,'\nsub:',sub,'\nval:',val)
		if gbl != g:
			g = gbl
			gref=iris.gref(gbl)	
		if sub == ['']:
			gref[None]=val
		else:
			gref[sub]=val
					
#;print('\n\tdone')	
fil.close()
return 1
}

}
