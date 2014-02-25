var bigot = require("./../lib/index.js");

var source = "<h1>{title}</h1><h6>{subtitle}</h6><p>{content}</p>";

var data = {title: "Hello World!", subtitle: "and hello Bigot!", content: "This is a Bigot test template"};

console.log("Here is the compiled source:\n"+bigot.compile(source, data));