#!/bin/bash
SOURCE_DIR=$1
BACKUP_DIR=$2
REPORT_FILE="system_report.txt"
ERROR_LOG="error_log.txt"

processed_count=0
duplicate_count=0
backup_count=0

> "$REPORT_FILE" 2> /dev/null
> "$ERROR_LOG" 2> /dev/null

if [ ! -d "$SOURCE_DIR" ] || [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: Source or backup directory does not exist." >> "$ERROR_LOG"
    exit 1
fi

declare -A file_hashes

for file in "$SOURCE_DIR"/*; do
    if [ -f "$file" ]; then
        ((processed_count++))
        checksum=$(md5sum "$file" 2>>"$ERROR_LOG" | awk '{print $1}')
        
        if [ -n "${file_hashes[$checksum]}" ]; then
            ((duplicate_count++))
            echo "Duplicate found: '$file' matches existing file '${file_hashes[$checksum]}'" >> "$REPORT_FILE"
        else
            file_hashes[$checksum]="$file"
            cp "$file" "$BACKUP_DIR/" 2>>"$ERROR_LOG"
            if [ $? -eq 0 ]; then
                ((backup_count++))
            fi
        fi
    fi
done

echo -e "\n=== Assignment Processing Summary ===" >> "$REPORT_FILE"
echo "Total files processed: $processed_count" >> "$REPORT_FILE"
echo "Duplicate submissions identified: $duplicate_count" >> "$REPORT_FILE"
echo "Unique files successfully backed up: $backup_count" >> "$REPORT_FILE"
