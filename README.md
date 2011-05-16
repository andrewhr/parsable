Parsable
==========

WIP

Parsable aims to be a easy bridge to importing data from csv file to a
Rails app. That's achieved by configuring your models through a simple
DSL, that will parse and import the given data directly to database.

It's my May 2011 RMU project. :)

### Goals ###

* Simple parser, wrapping the default 1.9.2 CSV parser.
* Setup model <=> headers relation through DSL.

### Requirements ###

For this first implementation, only ruby 1.9.2 or greater are supported.

### First iteration ###

* Create a simple gem, that currently only have the underlining parser,
  without the DSL stuff.

The parser is actualy a rewrite from a basic parser that I wrote, based
on 1.8.7 CSV lib.

The parser is really pretty simple, due to fact that FasterCSV is really
good. Heres a simple way to use it:

        parser = Parser.new "filename.csv"
        parser.parse_attribute :attribute_name_same_as_header
        parser.parse_attribute :nice_attribute, :from_column => :very_ugly_name
        records = parser.parse

Only explicit request attributes will be imported. That way we could ignore unwanted columns, and made the proccess less error prone.

The records are returned as array of Hash attributes. That was made for
easy record creation through ActiveRecord.

### Todo for the next iteration ###

* Support for ruby 1.8 through explicity import of FasterCSV.
* Specify column through a DSL incorporated to ActiveRecord models.
* Error reporting.

### Copywrith ###

Copyright (c) 2011 Andrew Rosa. See LICENSE.txt for
further details.
