
read -p "enter the backup path" path

if [ -z "$path" ]; then
    echo "Please provide the path."
    exit 1
else
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    Backup_path="/home/kumar/shellscripting/shellscripting_backup"

    mkdir -p "$Backup_path"  # this will create a backup directory if not present

    # Find files older than 30 days and store them in an array
    Tempfiles=($(find "$path" -type f -mtime +30))

    if [ ${#Tempfiles[@]} -eq 0 ]; then
        echo "No log files created in the past 30 days."
    else
        echo "Moving all the log files created 30 days ago to Backup_path: $Backup_path"
        for Tempfile in "${Tempfiles[@]}"; do
            #mv "$Tempfile" "$Backup_path"
            cp "$Tempfile" "$Backup_path" # as a demo i am using cp but we need to use mv
            echo "$Tempfile moved to Backup_path: $Backup_path"
        done
    fi
fi


backup_Tempfiles=($(find "$Backup_path" -type f -mtime +30))

if [ ${#backup_Tempfiles[@]} -eq 0 ]; then
    echo "No backup files to move to S3 Glacier"
else
    aws s3 cp $Backup_path s3://log-backup-cppe/backuplogs/ --storage-class GLACIER --recursive
fi


