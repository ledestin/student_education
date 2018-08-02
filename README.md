# Student education

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup
    % rake db:setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [Heroku Local]:

    % heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

You can run tests with this:

    % rake spec

Or if you're on a Linux server:

    % xvfb-run rake spec

## Using the app

After you run `% heroku local`, the application will be available at
[localhost:3000]. You can CRUD [students] and [teachers] with your API client of
choice; the API is restful.

At the moment, UI includes a list of teachers on home page. If you click on a
teacher, you'll get to the list of students of that teacher. Student info
includes lesson progress. If there's a problem loading teachers or students, an
error will be shown.

[localhost:3000]: http://localhost:3000
[students]: http://localhost:3000/students
[teachers]: http://localhost:3000/teachers
