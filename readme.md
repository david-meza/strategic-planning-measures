[![Stories in Ready](https://badge.waffle.io/david-meza/strategic-planning-measures.png?label=ready&title=Ready)](https://waffle.io/david-meza/strategic-planning-measures)
[![Build Status](https://travis-ci.org/david-meza/strategic-planning-measures.svg?branch=master)](https://travis-ci.org/david-meza/strategic-planning-measures)


# Strategic Planning Measures

Web app that captures data and measures for the COR strategic plan

### Demo

* Heroku: [Open](https://strategic-planning.herokuapp.com/)

### Getting Started

1. Clone this repository on your local environment. 
2. Run `bundle install` to get all gem dependencies and prepare your database by running `rake db:create db:migrate`.
3. Optionally, run `rake db:seed` to fill your db with fake seed data.

### Setting up the test environment

This application uses RSpec Rails, Guard, Shoulda matchers, and Factory Girl for testing.

* To prepare your test database after first cloning/forking this repository run `rake db:test:prepare`
* To run all tests one time simple run `rspec` or `bundle exec rspec` if you don't have the gem installed globally
* To watch for changes in spec files or app files and re-run your test suite each time run `guard` or `bundle exec guard`




