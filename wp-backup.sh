#!/bin/bash

# CONFIG
BACKUP_DIR="/home/user/wp-backups"
WEB_DIR="/usr/local/lsws/wordpress"
DB_NAME="dbname"
DB_USER="dbuser"
DB_PASS="dbpassword"
DATE=$(date +"%Y-%m-%d-%H%M")

# Create backup folder
mkdir -p "$BACKUP_DIR"

# Backup database using mariadb-dump
mariadb-dump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_DIR/db-$DATE.sql"

# Backup WordPress files with relative path
cd "$WEB_DIR"/..
tar -czf "$BACKUP_DIR/files-$DATE.tar.gz" "$(basename "$WEB_DIR")"

# Optional: Delete backups older than 30 days
find "$BACKUP_DIR" -type f -mtime +30 -delete
