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

Teacher attributes of note:
```
name
```

Student attributes of note:
```
name
completed_lesson
completed_part
teacher_id
```

At the moment, UI includes a list of teachers on home page. If you click on a
teacher, you'll get to the list of students of that teacher. Student info
includes lesson progress. If there's a problem loading teachers or students, an
error will be shown.

[localhost:3000]: http://localhost:3000
[students]: http://localhost:3000/students
[teachers]: http://localhost:3000/teachers

## Discussion

It is definitely a work in progress, and is more of an exploratory spike. The
code isn't as clean as I'd like it to be.

The test description was nudging me towards API + SPA, plus Blake uses Ember, so
I went that way. I've chosen React for UI + Backbone for CRUD requests, as I
felt that Redux would be an overkill.

I show a generic "Server error" on AJAX errors, and clear existing errors on
url change. It works for the application as it is (it just loads data at
present), and may not work when create/update are added. I follow the rule that
the future will take care of itself. I will change error handling if it needs to
be changed.

[App] class could use some refactoring; fetching teachers doesn't really belong
there. I also shouldn't have tried caching teachers for the report page and just
loaded the corresponding teacher again.

I didn't introduce `Person` class as I felt it was too early in the spike. Name
uniqueness isn't enforced by unique indexes; no time cause I spent a lot of time
architecting SPA.

I am happy with how [Student#complete] turned out. I stared with
[Student#complete_next_part] because I felt that it's better not to give user a
way to set progress wrongly, but then I realised that UI may send such a
request. Limiting that via validations is also an option, but it'd make console
data manipulation and testing problematic.

I feel that [LessonProgress] is a good way to do it. For example,
`LessonProgress#next` is a great name. If I had that method in `Student`, what
would it be called? `#next_lesson_progress` is worse than `#next` and was hard
to come up with.

[App]:
https://github.com/ledestin/student_education/blob/master/app/javascript/src/js/app.js#L13
[Student#complete]: https://github.com/ledestin/student_education/blob/readme/app/models/student.rb#L20
[Student#complete_next_part]:
https://github.com/ledestin/student_education/blob/3e07e5092b4d881b75eba79187649f769cb46580/app/models/student.rb#L13
[LessonProgress]:
https://github.com/ledestin/student_education/blob/readme/app/models/lesson_progress.rb
