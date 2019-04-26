#!/bin/bash

date=$(date +"%Y%m" -d "-1 month")
day=$(date +"%d")
path=/path/to/your/source
sync_path=/your/destination
password="yourpassword"

cd $path

dirs=$(ls -d */)

if [ "$day" == "$1" ]; then

        for dir in $dirs
        do
                cd $path/$dir
                echo Processing... $(pwd)
                ls | grep $date | sshpass -p $password rsync -avh --progress --append-verify --files-from=- . $sync_path/$dir
                wait
                ls | grep $date | xargs -d"\n" rm
        done
else
        echo "Error: not first day of the month"
fi
