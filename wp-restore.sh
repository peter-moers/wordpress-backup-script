#!/bin/bash

# CONFIG
BACKUP_DIR="/home/user/wp-backups"
WEB_DIR="/usr/local/lsws/wordpress"
DB_NAME="dbname"
DB_USER="dbuser"
DB_PASS="dbpassword"

echo "Available backups:"
echo

# Get list of unique backup timestamps
backups=($(ls "$BACKUP_DIR"/db-*.sql | sed -E 's/.*db-(.*)\.sql/\1/' | sort -r))

# Check if any backups exist
if [ ${#backups[@]} -eq 0 ]; then
  echo "No backups found in $BACKUP_DIR."
  exit 1
fi

# Display backups with index
for i in "${!backups[@]}"; do
  echo "$i) ${backups[$i]}"
done

echo
read -p "Enter the number of the backup to restore: " index

# Validate selection
if ! [[ "$index" =~ ^[0-9]+$ ]] || [ "$index" -ge "${#backups[@]}" ]; then
  echo "Invalid selection."
  exit 1
fi

TIMESTAMP="${backups[$index]}"
DB_FILE="$BACKUP_DIR/db-$TIMESTAMP.sql"
FILES_ARCHIVE="$BACKUP_DIR/files-$TIMESTAMP.tar.gz"

echo "Restoring backup from $TIMESTAMP..."
echo

# Restore database
echo "Restoring database..."
mariadb -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$DB_FILE"

# Restore WordPress files
echo "Restoring WordPress files..."
rm -rf "$WEB_DIR"
mkdir -p "$WEB_DIR"
tar -xzf "$FILES_ARCHIVE" -C "$(dirname "$WEB_DIR")"

echo
echo "Restore complete."
