#!/bin/bash

# -d (date string) is for test purposes only, will be replace by date only on backup server

LDMONTH=$(TZ=MST-24 date +%d)
#LDMONTH=1
ISMONDAY=$(date +%u)
#ISMONDAY=1
DAILY=$(date +%A)
#DAILY=Friday
DAY=$(date +%w) 
#DAY=4

WEEKLY=$(date +%Y-%m-%d)

MONTHLY=$(date +%B)

FILENAME=$(date +%m%d%y)_backup.tar.gz

SRC=/var/www/html/

DISK3=/data/disk3/site_data

DISK4=/data/disk4/site_data

echo Date: $(date +%Y-%m-%d) >> /home/webmaster/backup2.log

#echo Check if tomorrow is the first day of the new month: $LDMONTH >> /home/webmaster/backup2.log

echo Source path: $SRC >> /home/webmaster/backup2.log

echo DISK3 path: $DISK3 >> /home/webmaster/backup2.log

echo DISK4 path: $DISK4 >> /home/webmaster/backup2.log

#echo Filename: $FILENAME >> /home/webmaster/backup2.log

if [ $LDMONTH -eq 1 ]; then

	echo 'backup to monthly started' >> /home/webmaster/backup2.log
	
	echo Monthly backup path: $DISK4/Monthly	

	if [ -d $DISK4/Monthly ]; then

		echo $DISK4/Monthly exist >> /home/webmaster/backup2.log

		#cd $SRC

		#tar -zcf $DISK4/Monthly/$MONTHLY/$FILENAME --exclude '*cache*' --exclude '.git/*' --exclude 'episodes/*' .

		rsync -avh --progress --exclude-from=/home/webmaster/backup_rules.txt --append $SRC $DISK4/Monthly/

		wait

	else

		echo $DISK4/Monthly does not exist >> /home/webmaster/backup2.log

		mkdir -p $DISK4/Monthly

		#cd $SRC

		#tar -zcf $DISK4/Monthly/$MONTHLY/$FILENAME --exclude '*cache*' --exclude '.git/*' --exclude 'episodes/*' .
		
		rsync -avh --progress --exclude-from=/home/webmaster/backup_rules.txt --append $SRC $DISK4/Monthly/

		wait
	fi

	echo 'monthly backup finished' >> /home/webmaster/backup2.log

fi

if [ $ISMONDAY -eq 1 ]; then

	echo 'backup to weekly started' >> /home/webmaster/backup2.log
	
	echo Weekly backup path: $DISK4/Weekly 	

	if [ -d $DISK4/Weekly ]; then

		echo $DISK4/Weekly exist >> /home/webmaster/backup2.log

		#cd $SRC

		#tar -zcf $DISK4/Weekly/$WEEKLY/$FILENAME --exclude '*cache*' --exclude '.git/*' --exclude 'episodes/*' .

		rsync -avh --progress --exclude-from=/home/webmaster/backup_rules.txt --append $SRC $DISK4/Weekly/

		wait

	else

		echo $DISK4/Weekly does not exist >> /home/webmaster/backup2.log

		mkdir -p $DISK4/Weekly

		#cd $SRC

		#tar -zcf $DISK4/Weekly/$WEEKLY/$FILENAME --exclude '*cache*' --exclude '.git/*' --exclude 'episodes/*' .

		rsync -avh --progress --exclude-from=/home/webmaster/backup_rules.txt --append $SRC $DISK4/Weekly/

		wait

	fi

	echo 'weekly backup finished' >> /home/webmaster/backup2.log

fi

echo backup to daily started >> /home/webmaster/backup2.log

if [ $DAY -eq 0 ]; then

	echo daily backup path: $DISK4/Daily/$DAILY >> /home/webmaster/backup2.log

	rsync -avh --progress --exclude-from=/home/webmaster/backup_rules.txt --append $SRC $DISK4/Daily/$DAILY/

	wait

elif [ $DAY -eq 6 ]; then

	echo daily backup path: $DISK4/Daily/$DAILY >> /home/webmaster/backup2.log

	rsync -avh --progress --exclude-from=/home/webmaster/backup_rules.txt --append $SRC $DISK4/Daily/$DAILY/

	wait

else
	echo daily backup path: $DISK3/Daily/$DAILY >> /home/webmaster/backup2.log

	rsync -avh --progress --exclude-from=/home/webmaster/backup_rules.txt --append $SRC $DISK3/Daily/$DAILY/

	wait
fi

echo daily backup finished >> /home/webmaster/backup2.log

echo $'\n\n' >> /home/webmaster/backup2.log
