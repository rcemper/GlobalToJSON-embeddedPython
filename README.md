# GlobalToJSON-Academic
This package offers a utility to load a Global into JSON object and to create a    
Global from this type of JSON object. *Academic* refers to the structer created.    
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
IRISAPP>write ##class(community.objectscript.ClassExample).Test()
```
### Code Quality 
![CodeQuality](https://raw.githubusercontent.com/rcemper/GlobalToJSON-Academic/master/CodeQuality.JPG) 

[Article in DC](https://community.intersystems.com/post/dataset-lightweight-mn)
