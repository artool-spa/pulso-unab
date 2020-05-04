# Pulso Unab

Pulso UNAB gets and processes tickets from different sources (provided by client) and send emails according to a number of criteria. It also serves as a data source for Tableau.

Things you may want to cover:

* Running on Ruby 2.5.1, Rails 5.2.1

* System dependencies: Ubuntu 18.04 and up, PostgreSQL 10.x and up

* Database creation and initial seed
`rails db:drop && rails db:create && rails db:migrate && rails db:seed`

* Important Tasks:
`rails tickets:all`: Brings all tickets between a given period of time. Includes all answer sources.
`rails careers:all`: Insert careers to the system from a local XLSX file.

