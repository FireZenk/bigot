(function() {
  var Bigot;

  Bigot = require("./../lib/index.js");

  exports.BigotTest = {
    'Test 1 - Render arrays': function(test) {
      var data, result, source;
      source = "<h1>{title}</h1><h6>{subtitle}</h6><p>{content}</p><p>2 + 3 = {func}</p>";
      data = {
        title: "Hello World!",
        subtitle: "and hello Bigot!",
        content: "This is a Bigot test template",
        func: function() {
          return 2 + 3;
        }
      };
      result = Bigot.render(source, data);
      test.equal(result, "<h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template</p><p>2 + 3 = 5</p>");
      return test.done();
    },
    'Test 2 - Render array of objects': function(test) {
      var data, result, source;
      source = "<ul>{loop names}<li>{@}</li>{end names}</ul>";
      data = {
        names: ["Abby", "Matt", "Jhon"]
      };
      result = Bigot.render(source, data);
      test.equal(result, "<ul><li>Abby</li><li>Matt</li><li>Jhon</li></ul>");
      return test.done();
    },
    'Test 3 - Render objects into array of objects': function(test) {
      var data, result, source;
      source = "<ul>{loop people}<li>{name}, {age}</li>{end people}</ul>";
      data = {
        people: [
          {
            name: "Abby",
            age: "24"
          }, {
            name: "Matt",
            age: "32"
          }, {
            name: "John",
            age: "18"
          }
        ]
      };
      result = Bigot.render(source, data);
      test.equal(result, "<ul><li>Abby, 24</li><li>Matt, 32</li><li>John, 18</li></ul>");
      return test.done();
    },
    'Test 4 - Render arrays into array of objects': function(test) {
      var data, result, source;
      source = "<ul>{loop people}<li>{name}, {age} {loop sports}<span>{@}</span>{end sports}</li>{end people}</ul>";
      data = {
        people: [
          {
            name: "Abby",
            age: "24",
            sports: ["hockey", "curling"]
          }, {
            name: "Matt",
            age: "32",
            sports: ["futbol"]
          }, {
            name: "John",
            age: "18",
            sports: ["tennis", "basketball"]
          }
        ]
      };
      result = Bigot.render(source, data);
      test.equal(result, "<ul><li>Abby, 24 <span>hockey</span><span>curling</span></li><li>Matt, 32 <span>futbol</span></li><li>John, 18 <span>tennis</span><span>basketball</span></li></ul>");
      return test.done();
    },
    'Test 5 - Render object arrays into array of objects': function(test) {
      var data, result, source;
      source = "<ul>{loop people}<li>{name}, {age} {loop activities}<span>{sport} and {hobby}</span>{end activities}</li>{end people}</ul>";
      data = {
        people: [
          {
            name: "Abby",
            age: "24",
            activities: [
              {
                sport: "hockey",
                hobby: "drive"
              }
            ]
          }, {
            name: "Matt",
            age: "32",
            activities: [
              {
                sport: "football",
                hobby: "pets"
              }
            ]
          }, {
            name: "John",
            age: "18",
            activities: [
              {
                sport: "tennis",
                hobby: "videogames"
              }
            ]
          }
        ]
      };
      result = Bigot.render(source, data);
      test.equal(result, "<ul><li>Abby, 24 <span>hockey and drive</span></li><li>Matt, 32 <span>football and pets</span></li><li>John, 18 <span>tennis and videogames</span></li></ul>");
      return test.done();
    },
    'Test 6 - Render including templates': function(test) {
      var data, result, source;
      source = "{include header}<h1>{title}</h1><h6>{subtitle}</h6><p>{content}</p><p>2 + 3 = {func}</p>{include footer}";
      data = {
        header: "./test/header.html",
        footer: "./test/footer.html",
        title: "Hello World!",
        subtitle: "and hello Bigot!",
        content: "This is a Bigot test template",
        func: function() {
          return 2 + 3;
        }
      };
      result = Bigot.render(source, data);
      test.equal(result, "<html><head><title>Bigot test</title></head><body>\n<h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template</p><p>2 + 3 = 5</p></body></html>\n");
      return test.done();
    }
  };

  /*
  
  '<html><head><title>Bigot test</title></head><body>\n<h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template</p><p>2 + 3 = 5</p></body></html>\n'
  '<html><head><title>Bigot test</title></head><body><h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template</p><p>2 + 3 = 5</p></body></html>
  
  #test5
  
  source = "\t<ul>\n{loop people}\t\t<li>{name}, {age} {loop activities}<span>{sport} and {hobby}</span>{end activities}</li>\n{end people}\t</ul>";
  
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
  
  #test6
  
  source = "{include header}<h1>{title}</h1>\n\t<h6>{subtitle}</h6>\n\t<p>{content}</p>\n\t<p>2 + 3 = {func}</p>{include footer}";
  
  data = {header: "./test/header.html", footer: "./test/footer.html",title: "Hello World!", subtitle: "and hello Bigot!",
        content: "This is a Bigot test template", func: function() {return 2+3}};
  
  console.log("TEST1: Here is the rendered source:\n\t"+bigot.render(source, data));
  */


}).call(this);
