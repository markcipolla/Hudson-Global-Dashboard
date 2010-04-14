Hudson Global Dashboard
============

### For tracking to builds on multiple machines running Hudson. ###

The Hudson Global Dashboard is an idea that stems from the Panic Board ( http://www.panic.com/blog/2010/03/the-panic-status-board/ ). We had a scenario where we had multiple machines running Hudson, and for knowing at-a-glance the status of a build we relied either on build lights (USB lights, changing red to green depending on build) or CCMenu.

## Problem with this ##
* CCMenu cannot be easily seen by people walking by
* Build lights can only be one per machine, however we are running multiple builds on a single machine.

## Usage ##
* Check the code out.
* Change the IP addresses in the hudson_global_dashboard.rb file.
* Run the app via 'ruby hudson_global_dashboard.rb'
* It runs on 'http://localhost:4567'
* Enjoy 

## Installation ##
    
    git clone git@github.com:markcipolla/Hudson-Global-Dashboard.git
    bundle install
    padrino rake seed
    padrino start

The "padrino rake seed" lets you set up the first admin account, so you can login.
Point your browser to http://localhost:3000/admin so you can login. After adding at least one build, head to http://localhost:3000
