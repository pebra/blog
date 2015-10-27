---
layout: post
title: "When struggling with postgresql and utf8/latin"
date: 2013-06-10 18:40
comments: true
tags: 
- coding
- postgresql
- postgres
- ubuntu
---

This is just a little information dump for me, you probably won't have these issues.

Lately I tried to switch the database in a Rails app from SQLite to PostgreSQL.
However, after installing postgres and setting up my database.yml file on my vagrant ubuntu(precise32) box, I fire

``` ruby
	rake db:create
```

and it greets me with

``` ruby
	Couldn't create database for {"adapter"=>"postgresql", "encoding"=>"unicode", 
		"database"=>"stuff_development", "pool"=>5, "username"=>"stuffer", "password"=>nil}
	PG::Error: ERROR:  encoding "UTF8" does not match locale "en_US"
	DETAIL:  The chosen LC_CTYPE setting requires encoding "LATIN1".
	: CREATE DATABASE "stuff_test" ENCODING = 'unicode'
```

There are some encoding issues, yeah!
After some googeling I tried the solution provided by this [post](https://coderwall.com/p/j-_mia) which unfortunatly ended up with this:

``` sql
	postgres=# create database template1 with owner=postgres template=template0 encoding='UTF8';
	ERROR:  encoding "UTF8" does not match locale "en_US"
	DETAIL:  The chosen LC_CTYPE setting requires encoding "LATIN1".
```
But adding some additional options did the trick

``` sql
	create database template1 with owner postgres encoding='UTF-8' 
		lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;
```

In summary, when you get such errors try these steps

``` bash
	sudo su postgres
	psql
```

``` sql
	update pg_database set datistemplate=false where datname='template1';
	drop database Template1;
	create database template1 with owner=postgres encoding='UTF-8' 
		lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;
	update pg_database set datistemplate=true where datname='template1';
```
