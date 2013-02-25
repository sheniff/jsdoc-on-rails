JSDoc to Rails
###

Automatic JSDoc documentation generator written in an for Ruby on Rails

Installation
###

* Install gem (WIP)

* Run jsdoc:generate

```
rake jsdoc:generate SRC=/path/to/your/js
```

* All the doc will be ported to the database under the following Database structure

```
  JsdocSection => Each parsed js file
  |
  |- JsdocSectionAttribute => Section's attributes
  |
  |- JsdocFunction => Each one of the functions defined in a section
    |
    |- JsdocFunctionAttribute => Function's attributes
```
