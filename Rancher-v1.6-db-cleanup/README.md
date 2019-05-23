# Rancher database cleanup script
This script will cleanup a number of purged items from Rancher's database.

**Prep Work**
This script can put a heavy load on the database server, so this script should be done off hours and/or during a maintenance window.
Also, we would recommend not doing any large deployments during this work.

**Running the script for External database**
Please take a database backup using this command.
`mysqldump -h <<db-host>> -u <<db-user>> -p <<db-name>> | gzip > ./RancherDBBackup_PreCleanup.sql`

Please run the following SQL commands.
`mysql -h <<db-host>> -u <<db-user>> -p <<db-name>> < ./cleanup.sql`

Please take a database backup using this command. (Optional)
`mysqldump -h <<db-host>> -u <<db-user>> -p <<db-name>> | gzip > ./RancherDBBackup_PostCleanup.sql`


**Running the script for single node using internal database**
Grab the containter ID for the Rancher server.
`docker ps | grep rancher`

Please take a database backup using this command.
`docker exec <<Containter ID>> /usr/bin/mysqldump | gzip > ./RancherDBBackup_PreCleanup.sql`

Please run the following SQL commands.
`cat ./cleanup.sql | docker exec -i <<Containter ID>> mysql cattle`

Please take a database backup using this command. (Optional)
`docker exec <<Containter ID>> /usr/bin/mysqldump | gzip > ./RancherDBBackup_PostCleanup.sql`

