[![Stories in Ready](https://badge.waffle.io/david-meza/strategic-planning-measures.png?label=ready&title=Ready)](https://waffle.io/david-meza/strategic-planning-measures)
[![Build Status](https://travis-ci.org/david-meza/strategic-planning-measures.svg?branch=master)](https://travis-ci.org/david-meza/strategic-planning-measures)


# Strategic Planning Measures

Web app that captures data and measures for the COR strategic plan

### Internal Production Server

* [Open](http://strategicplanning/)

*Note:* This link won't work outside the internal oaktree network

### Demo

* Heroku: [Open](https://strategic-planning.herokuapp.com/)

### Getting Started

1. Clone this repository on your local environment. 
2. Run `bundle install` to get all gem dependencies and prepare your database by running `rake db:create db:migrate`.
3. Optionally, run `rake db:seed` to fill your db with fake seed data.
4. To run in a local dev server run `puma -C "-"`. Your application will now be accessible at `http://localhost:9292/`

### Setting up the test environment

This application uses RSpec Rails, Guard, Shoulda matchers, and Factory Girl for testing.

* To prepare your test database after first cloning/forking this repository run `rake db:test:prepare`
* To run all tests one time simple run `rspec` or `bundle exec rspec` if you don't have the gem installed globally
* To watch for changes in spec files or app files and re-run your test suite each time run `guard` or `bundle exec guard`


## Deployment to Local Servers

####Useful Red Hat commands:

**Start Puma server:** `bundle exec puma -e production --daemon`

**Restart a running Puma server:** `pumactl restart`

**Restore pg dump:** `pg_restore --verbose --clean --no-acl --no-owner -h localhost -U user -d dbname latest.dump`

**Create a pg dump:** `pg_dump -Fc --no-acl --no-owner -h localhost -U strategicplanning strategic_planning_production > strategic_planning_production.dump`

**See which services are running:** `ps -ef | grep puma`

**Kill a running service:** `kill pid`

**Run a service on machine startup:** `chkconfig postgresql-9.5 on`

**Do something with a service:** `sudo service nginx restart`

**Check out RHEL version:** `cat /etc/redhat-release`

**Get number of CPU cores:** `grep -c processor /proc/cpuinfo`

**If system is broken and missing essential packages like service and chkconfig:** `sudo yum reinstall initscripts` and then `export PATH=$PATH:/sbin` to add /sbin to execute those paths without the /sbin prefix

###Installing Latest Postgres:

####Uninstalling current pg:
1. sudo yum erase postgresql postgresql-libs.x86_64 (or sudo yum remove postgresql postgresql-libs.x86_64)
2. sudo yum clean all
3. rm -rf /var/lib/pgsql/

####Installing most recent pg:
1. sudo yum localinstall https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-6-x86_64/pgdg-redhat95-9.5-2.noarch.rpm
2. sudo yum install postgresql95.x86_64 postgresql95-server.x86_64 postgresql95-devel.x86_64

####Initializing the db:
1. sudo service postgresql-9.5 initdb
2. sudo chkconfig postgresql-9.5 on
3. sudo service postgresql-9.5 start

Note: May need to edit this file sudo vim /var/lib/pgsql/9.5/data/pg_hba.conf and change ident to trust or at least md-5

###Installing ROR on Red Hat Enterprise Linux Server release 6.7

####Installing Ruby (with RVM):

1. gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
2. \curl -sSL https://get.rvm.io | bash -s stable
3. vim ~/.bash_profile 
4. Add source ~/.profile at the bottom
5. Refresh your paths: source ~/.bash_profile
6. rvm install ruby-2.3.0
7. gem install bundler —no-doc

####Cleaning up Yum:

1. sudo rm /etc/yum.repos.d/ruby_1.9.3.repo
2. sudo vim /etc/yum.conf -> Replace $releasever with 6
3. sudo yum upgrade
4. sudo yum clean all
5. Open up ~/.profile or ~/.bash_profile and append :/sbin to the $PATH. For example: export PATH="$PATH:$HOME/.rvm/bin:/sbin”
6. Refresh your profile with source ~/.bash_profile

####Installing Nginx:

1. sudo vim /etc/yum.repos.d/nginx.repo

```bash
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/rhel/6/$basearch/
gpgcheck=0
enabled=1
```

2. sudo yum install nginx
3. sudo service nginx start (If you get command service does not exist, look at steps 5 and 6 of cleaning up yum or try sudo yum reinstall initscripts before these steps)
4. Verify it installed correctly by visiting your server URL (e.g. http://rorprdapp1.ci.raleigh.nc.us/)
5. sudo chkconfig nginx on
6. sudo vim /etc/nginx/conf.d/default.conf

Delete or comment out everything (note: there’s a closing bracket at the very end of the file). Paste the following:

```bash
upstream app {
  # Path to Puma SOCK file, as defined previously
  server unix:/home/CORALEIGH/username/repo-name/shared/sockets/puma.sock fail_timeout=0; # Path where web server (puma in this case) will be listening
}

server {
  listen 80;
  server_name localhost;

  root /home/CORALEIGH/username/repo-name/public; # App root path

  try_files $uri/index.html $uri @app;

  location / {
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header Host $host;
    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_set_header Connection '';
    proxy_pass http://app;
  }

  location ~ ^/(assets|fonts|system)/|favicon.ico|robots.txt {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  error_page 500 502 503 504 /500.html;
  client_max_body_size 4G;
  keepalive_timeout 10;
}
```

7. sudo service nginx restart

####Configuring Postgres

1. Go through the installing latest postgres section if necessary
2. sudo su - postgres
3. createuser -s username
4. exit
5. psql -U username -h localhost -d postgres
6. CREATE DATABASE db_name;
7. \password
8. \q

####Optional: Migrating an existing database from Heroku

1. Wherever you have Heroku tool belt and remote installed run: heroku pg:backups capture
2. heroku pg:backups public-url (copy this URL)
3. On server run: cd ~/tmp
4. curl -o latest.dump “paste that URL here”
5. pg_restore --verbose --clean --no-acl --no-owner -h localhost -U username -d db_name latest.dump

####Pulling your RoR application (with Puma)

1. cd ~
2. git clone https://github.com/david-meza/strategic-planning-measures.git (Whatever you application repo web address is)
3. cd app
4. mkdir -p shared/pids shared/sockets shared/log
5. bundle install (If you have troubles installing pg, try gem install pg -- --with-pg-config=/usr/pgsql-9.5/bin/pg_config)
6. vim config/application.yml (paste your env variables)
7. sudo yum install nodejs npm
8. bundle exec rake assets:precompile
9. RAILS_ENV=production bundle exec rake db:migrate
10. bundle exec puma -e production --daemon

