
# README
consumerapp has the patient side app up of remedico

### Setup
####  Make directories required locally for logs 
``` 
mkdir shared shared/log shared/pids shared/sockets
```
####  Set up local database
```
# for local postgres
cp config/database-orginal.yml config/database.yml

CREATE USER remedico WITH PASSWORD 'xxxxxx';
CREATE DATABASE remedico_production; 
GRANT ALL PRIVILEGES ON DATABASE remedico_production to remedico;
```

####  Setting up the app
```
# build gems
bundle install
# to build schema
rails db:migrate
# to seed any inbuilt data 
rails db:seed
```

### Important commands

####  app on server
```
# reload nginx server
sudo /opt/nginx/sbin/nginx -s reload 

# run nginx server
sudo /opt/nginx/sbin/nginx

# stop puma
pumactl stop

#start puma
puma -d

# clobber and compile resources
RAILS_ENV=production rake assets:clobber
RAILS_ENV=production rake assets:precompile

# Run sidekiq
bundle exec sidekiq -d -L shared/log/sidekiq.log -q default -q mailers -c 8

# Test sidekiq on local
bundle exec sidekiq -e production

# Check redis status
/etc/init.d/redis_6379 status
```
####  Miscellaneous
```
# query to  print consultation details
select cs.id, p.id, p.name, cs.user_status, cs.pay_status, cs.amount, cp.coupon_code, cs.category, cs.created_at, cs.updated_at from patients p, consultations cs, coupons cp where p.id=cs.patient_id and cs.coupon_id=cp.id order by cs.id desc;

# to let git ignore files
git update-index --assume-unchanged config/database.yml
```

### App flow

The basic flow of the app is as follows:

```flow
st=>start: Start your consultation
e=>end
op1=>operation: Check if condition is preselected
cond1=>condition: Selected or Not?
op2=>operation: Display conditions list
op3=>operation: Display typeform
op4=>operation: Display payments index page
cond2=>condition: Free of redflags?
op5=>operation: Display success page
op6=>operation: Display failure page
op7=>operation: Payment
cond3=>condition: Payment successful?

st->op1->cond1
cond1(yes)->op3
cond1(no)->op2->op3
op3->cond2
cond2(yes)->op4->op7->cond3
cond2(no)->op6->e
cond3(yes)->op5->e
cond3(no)->op6->e
```


