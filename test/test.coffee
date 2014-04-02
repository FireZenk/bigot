Bigot = require("./../lib/index.js");

exports.BigotTest =

  'Test 01 - Render objects': (test) ->
    source = "<h1>{title}</h1><h6>{subtitle}</h6><p>{content}</p><p>2 + 3 = {func}</p>"

    data = title: "Hello World!", subtitle: "and hello Bigot!", content: "This is a Bigot test template", func: () -> 2+3

    result = Bigot.render source, data

    test.equal result,"<h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template</p><p>2 + 3 = 5</p>"
    do test.done

  'Test 02 - Render array of objects': (test) ->
    source = "<ul>{loop names}<li>{@}</li>{end names}</ul>"

    data = names: ["Abby","Matt","Jhon"]

    result = Bigot.render source, data

    test.equal result,"<ul><li>Abby</li><li>Matt</li><li>Jhon</li></ul>"
    do test.done

  'Test 03 - Render objects into array of objects': (test) ->
    source = "<ul>{loop people}<li>{name}, {age}</li>{end people}</ul>"

    data = people: [
            {name: "Abby", age: "24"},
            {name: "Matt", age: "32"},
            {name: "John", age: "18"}]

    result = Bigot.render source, data

    test.equal result,"<ul><li>Abby, 24</li><li>Matt, 32</li><li>John, 18</li></ul>"
    do test.done

  'Test 04 - Render arrays into array of objects': (test) ->
    source = "<ul>{loop people}<li>{name}, {age} {loop sports}<span>{@}</span>{end sports}</li>{end people}</ul>"

    data = people: [
            {name: "Abby", age: "24", sports: ["hockey","curling"]},
            {name: "Matt", age: "32", sports: ["futbol"]},
            {name: "John", age: "18", sports: ["tennis","basketball"]}]

    result = Bigot.render source, data

    test.equal result,"<ul><li>Abby, 24 <span>hockey</span><span>curling</span></li><li>Matt, 32 <span>futbol</span></li><li>John, 18 <span>tennis</span><span>basketball</span></li></ul>"
    do test.done

  'Test 05 - Render object arrays into array of objects': (test) ->
    source = "<ul>{loop people}<li>{name}, {age} {loop activities}<span>{sport} and {hobby}</span>{end activities}</li>{end people}</ul>";

    data = people: [{name: "Abby", age: "24", activities: [{
                                  sport: "hockey",
                                  hobby: "drive"}] },
                    {name: "Matt", age: "32", activities: [{
                                  sport: "football",
                                  hobby: "pets"}] },
                    {name: "John", age: "18", activities: [{
                                  sport: "tennis",
                                  hobby: "videogames"}] }]

    result = Bigot.render source, data

    test.equal result,"<ul><li>Abby, 24 <span>hockey and drive</span></li><li>Matt, 32 <span>football and pets</span></li><li>John, 18 <span>tennis and videogames</span></li></ul>"
    do test.done

  'Test 06 - Render including templates': (test) ->
    source = "{include header}<h1>{title}</h1><h6>{subtitle}</h6><p>{content}</p><p>2 + 3 = {func}</p>{include footer}"

    data = header: "./test/header.html", footer: "./test/footer.html", title: "Hello World!", subtitle: "and hello Bigot!", content: "This is a Bigot test template", func: () -> 2+3

    result = Bigot.render source, data

    test.equal result,"<html><head><title>Bigot test</title></head><body>\n<h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template</p><p>2 + 3 = 5</p></body></html>\n"
    do test.done

  'Test 07 - Render conditionals': (test) ->
    source = "<h1>{title}</h1><h6>{subtitle}</h6>{if bool_func}<p>{content}</p>{else}<p>{content2}</p>{end bool_func}<p>2 + 3 = {func}</p>"

    data = 
      title: "Hello World!", 
      subtitle: "and hello Bigot!"
      bool_func: () -> true 
      content: "This is a Bigot test template with conditionals"
      content2: "This is a Bigot test template"
      func: () -> 2+3

    result = Bigot.render source, data

    test.equal result,"<h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template with conditionals</p><p>2 + 3 = 5</p>"
    do test.done

  'Test 08 - Render nested conditionals': (test) ->
    source = "{if showMe}<p>Hello {if canShow}<span>friend!</span>{else}<span>{name}!</span>{end canShow}</p>{else}<p>Bye!</p>{end showMe}"

    data = 
      name: "Lightning McQueen"
      showMe: () -> true
      canShow: () -> false

    result = Bigot.render source, data

    test.equal result,"<p>Hello <span>Lightning McQueen!</span></p>"
    do test.done

  'Test 09 - Render nested conditionals with one loop inside': (test) ->
    source = "{if showMe}<p>Hello {if canShow}<span>friend!</span>{else}<span>{name}!</span><ul>{loop animals}<li>{@}</li>{end animals}</ul>{end canShow}</p>{else}<p>Bye!</p>{end showMe}"

    data = 
      name: "Lightning McQueen"
      showMe: () -> true
      canShow: () -> false
      animals: ["Lion","Tiger","Panther"]

    result = Bigot.render source, data

    test.equal result,"<p>Hello <span>Lightning McQueen!</span><ul><li>Lion</li><li>Tiger</li><li>Panther</li></ul></p>"
    do test.done

  'Test 10 - Render commented code': (test) ->
    source = "{comment Start of file}<h1>{title}</h1><h6>{subtitle}</h6>{comment Middle of file}<p>{content}</p><p>2 + 3 = {func}</p>{comment End of file}"

    data = title: "Hello World!", subtitle: "and hello Bigot!", content: "This is a Bigot test template", func: () -> 2+3

    result = Bigot.render source, data

    test.equal result,"<h1>Hello World!</h1><h6>and hello Bigot!</h6><p>This is a Bigot test template</p><p>2 + 3 = 5</p>"
    do test.done

  'Test 11 - Render code with helpers': (test) ->
    source = "<h1>{toUpper title}</h1><h6>{toLower subtitle}</h6>"

    data = 
      title: "Hello World!"
      subtitle: "and hello Bigot!"
      toUpper: (text) -> 
        text = JSON.stringify(this)
        text = text.substring(1, text.length-1)
        do text.toUpperCase
      toLower: (text) -> 
        text = JSON.stringify(this)
        text = text.substring(1, text.length-1)
        do text.toLowerCase

    result = Bigot.render source, data

    test.equal result,"<h1>HELLO WORLD!</h1><h6>and hello bigot!</h6>"
    do test.done
