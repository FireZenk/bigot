var bigot = require("./../lib/index.js");
var source, data;

/*
 * TEST ONE
 */

source = "<h1>{title}</h1>\n\t<h6>{subtitle}</h6>\n\t<p>{content}</p>\n\t<p>2 + 3 = {func}</p>";

data = {title: "Hello World!", subtitle: "and hello Bigot!", 
			content: "This is a Bigot test template", func: function() {return 2+3}};

console.log("TEST1: Here is the rendered source:\n\t"+bigot.render(source, data));

/*
 * TEST TWO
 */

source = "\t<ul>\n{¡names}\t\t<li>{@}</li>\n{!names}\t</ul>";

data = {names: ["Abby","Matt","Jhon"]};

console.log("TEST2: Here is the rendered source:\n"+bigot.render(source, data));

/*
 * TEST THREE
 */

source = "\t<ul>\n{¡people}\t\t<li>{name}, {age}</li>\n{!people}\t</ul>";

data = {people: [{name: "Abby", age: "24"},
				{name: "Matt", age: "32"},
				{name: "John", age: "18"}]};

console.log("TEST3: Here is the rendered source:\n"+bigot.render(source, data));

/*
 * TEST FOUR
 */

source = "\t<ul>\n{¡people}\t\t<li>{name}, {age} {¡sports}<span>{@}</span>{!sports}</li>\n{!people}\t</ul>";

data = {people: [{name: "Abby", age: "24", sports: ["hockey","curling"]},
				 {name: "Matt", age: "32", sports: ["futbol"]},
				 {name: "John", age: "18", sports: ["tennis","basketball"]}
				]};

console.log("TEST4: Here is the rendered source:\n"+bigot.render(source, data));

/*
 * TEST FIVE
 */

source = "\t<ul>\n{¡people}\t\t<li>{name}, {age} {¡activities}<span>{sport} and {hobby}</span>{!activities}</li>\n{!people}\t</ul>";

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

console.log("TEST5: Here is the rendered source:\n"+bigot.render(source, data));