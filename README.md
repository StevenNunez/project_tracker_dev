# Project Overview

Project Tracker will track projects and their collaborators. The steps take section is outlining any setup performed to get it working.

## Steps taken
* Generated with `rails new project_tracker_dev -d postgresql -T`
* Add rspec-rails to test and development group
* `bundle install`
* Run `rails g rspec:install`
* Remove `.warnings` from `.rspec` files.
* `rails g model project name github_url heroku_url`
* `rails g model collaboration project:belongs_to collaborator:belongs_to`
* `rails g model collaborator name github_username`
* `rake db:create db:migrate`
* `rails g rspec:model project`
* `rails g rspec:model collaboration`
* `rails g rspec:model collaborator`

Implement following tests/codez
"Projects are considered 'Done' when on github and heroku"
"Projects are can't have more than 4 collaborators"
"Projects must have at least one collaborator"
Bonus
"Projects can add user by their Github Username"

* Add associations between projects and collaborators through collaborations
* Add RestClient
* Add VCR and Webmock to test group
* Add factory_girl_rails and faker to test, development group
* Create Factory for collaborator

Implement following tests/codez
"Collaborators must have unique Github names"
"Collaborators must have github accounts"
"Collaborators can't have same project twice"
