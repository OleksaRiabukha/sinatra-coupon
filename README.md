## Coupon app

A simple json app for unique coupons generation. Stack: 

- ruby 3.0.1
- sinatra 2.1.0
- postgresql

To run the app:
- clone repo locally
- add your credentials (password, host and user) to access the postgres database to .env file. 
- run `bundle install` to install required gems locally
- run `rake db:setup`
- to start sever, run `thin start` or `rackup`
- make a get curl request to `/coupons`. You should be able to see a hash with coupon id, number and discount 
