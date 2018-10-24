
# DDM-Semaphore

DDM-Semaphore loads campaign's performance insights from Facebook Ads and Google Ads platforms and shows in a semaphore-views according to a defined period budget.

Things you may want to cover:

* Running on ruby 2.4.3, Rails 5.2.1

* System dependencies: Ubuntu 18.04 and up, PostgreSQL 10.x and up

* Database creation and initial seed
`rails db:drop && rails db:create && rails db:migrate && rails db:seed`

* Tasks:
`rails clients:all`: To load FB and GA data
`rails clients:fb`: To load FB data only
`rails clients:ga`: To load GA data only
