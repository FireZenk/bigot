[![Build Status](https://travis-ci.org/FireZenk/bigot.png?branch=master)](https://travis-ci.org/FireZenk/bigot)

Bigot
======
A little _moustache like_ template engine

How to install
------
```
npm install bigot --save
```
or

```
bower install bigot
```
or as a Grunt plugin

```
npm install grunt-contrib-bigot --save-dev
```

How to use
------
######Reserved keywords:
In order to be an engine of more semantic templates, Bigot use certain words to describe his actions, which shall therefore be reserved and may not be used as names or properties of objects/arrays.

This is the list of reserved keywords:
* loop
* end
* @

######Render objects:
```
source = "<h1>{title}</h1><h6>{subtitle}</h6><p>{content}</p><p>2 + 3 = {func}</p>";

data = {title: "Hello World!", subtitle: "and hello Bigot!", 
			content: "This is a Bigot test template", func: function() {return 2+3}};

console.log(bigot.render(source, data));

```
>output: `<h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template</p><p>2 + 3 = 5</p>`

######Render arrays:
```
source = "<ul>{loop names}<li>{@}</li>{end names}</ul>";

data = {names: ["Abby","Matt","Jhon"]};

console.log(bigot.render(source, data));
```
>output: `<ul> <li>Abby</li> <li>Matt</li> <li>Jhon</li> </ul>`

######Render array of objects:
```
source = "<ul>{loop people}<li>{name}, {age}</li>{end people}</ul>";

data = {people: [{name: "Abby", age: "24"},
				{name: "Matt", age: "32"},
				{name: "John", age: "18"}]};

console.log(bigot.render(source, data));
```
>output: `<ul> <li>Abby, 24</li> <li>Matt, 32</li> <li>John, 18</li> </ul>`

######Render arrays into array of objects:
```
source = "<ul>{loop people}<li>{name}, {age} {loop sports}<span>{@}</span>{end sports}</li>{end people}</ul>";

data = {people: [{name: "Abby", age: "24", sports: ["hockey","curling"]},
				 {name: "Matt", age: "32", sports: ["futbol"]},
				 {name: "John", age: "18", sports: ["tennis","basketball"]}
				]};

console.log(bigot.render(source, data));
```
>output: `<ul> <li>Abby, 24 <span>hockey</span><span>curling</span></li> <li>Matt, 32 <span>futbol</span></li> <li>John, 18 <span>tennis</span><span>basketball</span></li> </ul>`

######Render object arrays into array of objects:
```
source = "<ul>{loop people}<li>{name}, {age} {loop activities}<span>{sport} and {hobby}</span>{end activities}</li>{end people}</ul>";

data = {people: [{name: "Abby", age: "24", activities: [{
											sport: "hockey",
											hobby: "drive"}] },
				 {name: "Matt", age: "32", activities: [{
											sport: "football",
											hobby: "pets"}] },
				 {name: "John", age: "18", activities: [{
											sport: "tennis",
											hobby: "videogames"}] }
				]};

console.log(bigot.render(source, data));
```
>output: `<ul> <li>Abby, 24 <span>hockey and drive</span></li> <li>Matt, 32 <span>football and pets</span></li> <li>John, 18 <span>tennis and videogames</span></li> </ul>`

Author
------
__Jorge Garrido Oval__
* [https://github.com/FireZenk](https://github.com/FireZenk)

License
------
Bigot is released under the MIT license.