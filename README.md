# Anagram API

This is a basic API implementation for fast searching of Anagrams.

## High Level View
![Imgur](http://i.imgur.com/Y2fJ1rE.png)

## Configuration

To install dependencies:

* run `bundle install`

To get db setup (postgres):

* If you don't currently have PostgreSQL on your machine, you can do the following:

 - For mac users, you can download the app [here](posgresapp.com)

 - For windows and linux users, you can download [here](https://www.postgresql.org/download/)

* run `rake db:create db:migrate`

To run the server:

* run `rails s`

To run the application locally:

* `localhost:3000`

To run the test suite:

* `rake test`

## Implementation

I decided to implement the data store using a hash within a service PORO. The upfront time it takes
to find and add the anagrams for each word added to the corpus seemed to be a good trade-off for fast searching of
the anagrams for each word afterwards.

