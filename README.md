# JSDoc to Rails

Automatic JSDoc documentation generator written in an for Ruby on Rails

## Installation

* Edit your Gemfile and add this line

´´´
gem 'jsdoc-on-rails', :git => 'git://github.com/sheniff/jsdoc-on-rails.git'
´´´

* Then run

´´´
bundle install
´´´

* Next you need to install the migrations into your main application.

´´´
rake jsdoc-on-rails:install:migrations
´´´

* Migrate your database

´´´
rake db:migrate
´´´

## Use

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
