Bigot
======
A little _moustache like_ template engine


How to install
------
___
```
npm install bigot
```

How to use
------
___

######Render objects:
```
source = "<h1>{title}</h1><h6>{subtitle}</h6><p>{content}</p><p>2 + 3 = {func}</p>";

data = {title: "Hello World!", subtitle: "and hello Bigot!", 
			content: "This is a Bigot test template", func: function() {return 2+3}};

console.log(bigot.render(source, data));

```
######Render arrays:
```
source = "<ul>{¡names}<li>{@}</li>{!names}</ul>";

data = {names: ["Abby","Matt","Jhon"]};

console.log(bigot.render(source, data));
```

######Render array of objects:
```
source = "<ul>{¡people}<li>{name}, {age}</li>{!people}</ul>";

data = {people: [{name: "Abby", age: "24"},
				{name: "Matt", age: "32"},
				{name: "John", age: "18"}]};

console.log(bigot.render(source, data));
```