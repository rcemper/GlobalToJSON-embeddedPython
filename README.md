# GlobalToJSON-Academic
This package offers a utility to load a Global into JSON object and to create a    
Global from this type of JSON object. ***Academic*** refers to the structure created.    
each logical node of the Global is presented separated with all its descendants    
even if they don't contain any stored data.   

![](https://raw.githubusercontent.com/rcemper/GlobalToJSON-Academic/master/Globals.png)    

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
## Installation 
Clone/git pull the repo into any local directory
```
git clone https://github.com/rcemper/Dataset-simple-M-N.git
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
## How to Test it
This is the pre-loaded Global **^dc.MultiD** for testing.
![](https://raw.githubusercontent.com/rcemper/GlobalToJSON-Academic/master/Global.JPG)

Open IRIS terminal
```
$ docker-compose exec iris iris session iris
USER>
USER>; generate JSON object from Global
USER>set json=##class(dc.GblToJSON.A).do("^dc.MultiD")
USER>zw json
json={"node":"^dc.MultiD","val":"5","sub":[{"node":"1","val":"$lb(\"Braam,Ted Q.
\",51353)","sub":[{"node":"mJSON","val":"{}"}]},{"node":"2","val":"$lb(\"Klingma
n,Uma C.\",62459)","sub":[{"node":"2","sub":[{"node":"Multi","sub":[{"node":"a",
"val":"1"},{"node":"rob","sub":[{"node":"1","val":"rcc"},{"node":"2","val":"2222
"}]}]}]},{"node":"Multi","sub":[{"node":"a","val":"1"},{"node":"rob","sub":[{"no
de":"1","val":"rcc"},{"node":"2","val":"2222"}]}]},{"node":"mJSON","val":"{\"A\"
:\"ahahah\",\"Rob\":\"VIP\",\"Rob2\":1111,\"Rob3\":true}"}]},{"node":"3","val":"
$lb(\"Goldman,Kenny H.\",45831)","sub":[{"node":"mJSON","val":"{}"}]},{"node":"4
","val":"$lb(\"\",\"\")","sub":[{"node":"mJSON","val":"{\"rcc\":122}"}]},{"node"
:"5","val":"$lb(\"\",\"\")","sub":[{"node":"mJSON","val":"{}"}]}]}  ; <DYNAMIC OBJECT>

USER>; this is rather hard to read and follow
USER>write $$Do^ZPretty(json)
```
![](https://raw.githubusercontent.com/rcemper/GlobalToJSON-Academic/master/ZPretty.gif)

### Code Quality 
![CodeQuality](https://raw.githubusercontent.com/rcemper/GlobalToJSON-Academic/master/CodeQuality.JPG) 

[Article in DC](https://community.intersystems.com/post/dataset-lightweight-mn)
