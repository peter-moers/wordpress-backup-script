# Wordpress backup script
This simple linux script makes backups of a full Wordpress installation (files and database). It's fast and easy to use.

# Usage
* Copy the wp-backup.sh and wp-restore.sh scripts to your server
* Modify the settings to match your installation
* Set the scripts executable

## Backup
Just run the backup script...
 ~~~
./wp-backup.sh
~~~

## Restore
If you don't run the script as the owner of the folder, use sudo.
~~~
sudo ./wp-restore.sh
~~~
Select the backup you want to restore and press enter.
