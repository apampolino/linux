#!/bin/bash

host="ip_address"
dbname="dbname"
user="dbuser"
password="dbpass"
path=/directory/path
date=$(date +"%Y%m%d")

mysqldump --host=$host --user=$user --password=$password -v $dbname > $path/$dbname-$date.sql

wait

cd $path

latest_file=$(ls -t | head -1)
local_host="localhost"
local_dbname="hris"
local_user="user"
local_password="password"

mysql --host=$local_host --user=$local_user --password=$local_password -v $local_dbname < $path/$latest_file

wait