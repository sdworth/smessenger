# README

Welcome to SMessenger (Savannah Messenger), a small prototype app for users to send messages to each other.

## Run the application

You must have Ruby installed prior to running this application. A tool such as RVM or Rbenv can help with this if you don't already have it. This application was built with Ruby 2.6.5 .

You'll also need Node, and Yarn installed to support the Webpacker gem. NVM or Nodenv can help with that. This application was built with Node 13.1.0 . You can install yarn with:

```
$ npm install -g yarn
```

Once those are in place, install the bundler gem if you haven't already: 

```
$ gem install bundler
```

Next, install dependencies:

```
$ bundle install
$ yarn install
```

Setup the database, including seed data:

```
$ be rake db:setup
```

Once that's done, you can start up the application with

```
$ bundle exec rails s
```

The application will be running at http://localhost:3000.

## Signing In

There are two user accounts and a set of starting messages created through the seeds file (./db/seeds.rb). You can log in with either set of case-sensitive credentials below to see the messages, or add more users to the seeds file and send your own messages.

User 1
```
username: devola
password: popola
```

User 2
```
username: popola
password: devola
```

Conversations will live update using WebSockets--to see it in action, log in as these two users in either separate browsers or incognito windows, open their conversation with each other and send messages to watch the conversation update!

## Run the tests

After installing dependencies as described in the first section, both the unit tests and the Capybara based integration tests can be run using

```
$ bundle exec rspec
```

Additionally, this application has Rubocop installed to providing linting.

```
$ bundle exec rspec
```

## Design decisions

Notes on the thought process behind this project can be found at [DEVELOPMENT_NOTES.md](DEVELOPMENT_NOTES.md)