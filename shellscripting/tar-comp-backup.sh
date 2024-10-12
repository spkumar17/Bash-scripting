
read -p "enter the path" path

if [ -z "$path" ]; then
    echo "Please provide the path."
    exit 1
else
    # Find files older than 30 days and store them in an array
    Tempfiles=($(find "$path" -type f -mtime +30))

    if [ ${#Tempfiles[@]} -eq 0 ]; then    #The # in ${#...} is used to get the length of the array (or string).
        echo "No log files created in the past 30 days."
    else
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        Backup_path="/home/kumar/shellscripting/shellscripting_backup$TIMESTAMP"

        mkdir -p "$Backup_path"  # this will create a backup directory if not present
        Temptar=$(sudo tar -Pczf $path/shell-backupfile-$TIMESTAMP.tar.gz ${Tempfiles[@]} )   
        cp "$path/shell-backupfile-$TIMESTAMP.tar.gz" "$Backup_path"
    fi
fi


backup_Tempfiles=($(find "$Backup_path" -type f -mtime +30))

if [ ${#backup_Tempfiles[@]} -eq 0 ]; then
    echo "No backup files to move to S3 Glacier"
else
    aws s3 cp $Backup_path s3://log-backup-cppe/backuplogs/ --storage-class GLACIER --recursive
fi


