#! /bin/bash

clear

complete_date=$(date +%M-%d-%Y %H:%M:%S)
dir_by_year=$(date +%Y)
dir_by_day=$(date +%d)
current_month=$(date +%B)
backuproot="Backups"
backupByName="$backuproot/$dir_by_year"

if ! [ -d "$dir_by_year" ]; then
  mkdir -p $backupByName
  cd "$backupByName"
  echo "$dir_by_year has been created."

  if ! [ -d "$current_month" + "$days_in_month" ]; then
    for month_num in {1..12}; do
        dir_by_month=$(date -d "$dir_by_year-$month_num-01" +%B)

        mkdir -p "dir_by_month"
        cd "$dir_by_month"
        echo "$dir_by_month has been created."

        days_in_month=$(date -d "$dir_by_year-$month_num-01 +1 month -1 day" +%d)
          
          for d in $(seq -w 1 $days_in_month); do
            mkdir -p "$d"
            echo "$d has been created."

            if [ "$dir_by_month" = "$current_month" ] && ["$d" = "$dir_by_day"]; then
              cd "$d"
              backup_file="$complete_date-backup.log"

              echo "Backup completed @ $complete_date." > "$backup_file"
              cd ..

              echo "$complete_date: Backup occured" >> ~/finishedBackups.log
            fi
          
          done

        cd ..
        
    done
  fi
fi
