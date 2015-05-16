# README

A proof of concept netzke component with a testcase that breaks pagination under postgresql (at the time of writing), due to [the behavior of `limit by ... offset ...` under postgres](http://www.postgresql.org/docs/9.3/static/queries-limit.html)

The basic test case is:
- An app with one model, `Author(id, name, created_at, updated_at)`
- One `Netzke::Basepack::Grid`, `Authors`, of `Author` records, sorted by the `name` column by default
- A test that generates a bunch of `Author` instances, all with the same `name` (so postgres can sort however it wants), loads the `Authors` grid and compares the entries in the grid with the entries generated. On my machine, this usually results in a few missed entries, e.g.

```
$ bundle exec rspec
F

Failures:

 1) Authors should not show the same record on two different pages
    Failure/Error: run_mocha_spec 'authors'
    RuntimeError:
      Failures:
      1) should not show the same record on two different pages
      Error: Error: expected [ 4,
        95,
        152,
        196,
        215,
        372,
        411,
        569,
        597,
        610,
        616,
        723,
        788,
        855,
        910 ] to sort of equal [] (http://127.0.0.1:42643/assets/netzke/testing/expect/expect.js:99)
    # ./spec/features/authors_spec.rb:11:in `block (2 levels) in <top (required)>'

Finished in 38.39 seconds (files took 2.36 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/features/authors_spec.rb:10 # Authors should not show the same record on two different pages
```

The files of interest are
- `spec/features/author_spec.rb`, and
- `spec/features/javascripts/authors.js.coffee`

(the rest is just boilerplate for Rails, included for the sake of reproducibility)


Like for any [netzke](https://github.com/netzke) project, you need:
- public/extjs should link to ExtJS (I used 5.1.1 GPL)
- public/images/icons should link to the famfam silk icons
