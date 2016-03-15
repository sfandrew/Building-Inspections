# README #

This is the repository for the Building Inspections app being developed for SFRENT. It will allow you to inspect buildings and stuff.

### Running Tests ###

* Make sure your DB is setup: 
```
#!bash

rake db:migrate RAILS_ENV=test
```
* Run rspec:
```
#!bash

rspec
```
* Specific tests:

```
#!bash

rspec spec/models                         # By Folder
rspec spec/models/inspections_spec.rb     # By File
rspec spec/models/inspections_spec.rb:23  # By line number
```


