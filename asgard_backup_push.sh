#!/bin/bash

rsync -acz --progress --exclude='.git/' --delete ~/{scripts,docs,books} asgard:~/google-drive/skynote_archive/current/ --backup --backup-dir=~/grive/skynote_archive/increment/`date +%Y-%m-%d`/

echo "Starting grive2 on the asgard.."

ssh asgard "nohup ~/asgard_configs/asgard_backup_push_server.sh > /var/log/grive/script.log 2> /var/log/grive/last.log < /dev/null &"

echo "Sync completed!"

