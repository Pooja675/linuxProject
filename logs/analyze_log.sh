#!/bin/bash

LOG_DIR="/home/pooja675/logs"
REPORT_FILE="/home/pooja675/logs/log_analysis_report.txt"

#set -x
ERROR_PATTERNS=("ERROR" "FATAL" "WARN")

echo "Analysing log files" > "$REPORT_FILE"
echo "========================" >> "$REPORT_FILE"

echo -e "\n List of log files updated in last 24 hours" >> "$REPORT_FILE"
LOG_FILES=$(find $LOG_DIR -name "*.log" -mtime -1) >> "$REPORT_FILE"
echo $LOG_FILES >> "$REPORT_FILE"

for LOG_FILE in $LOG_FILES; do
	for PATTERN in ${ERROR_PATTERNS[@]}; do
		echo -e "\nSearching $PATTERN log in $LOG_FILE file" >> "$REPORT_FILE"
		grep "$PATTERN" "$LOG_FILE" >> "$REPORT_FILE"
		echo -e "\nNumber of $PATTERN log in $LOG_FILE file" >> "$REPORT_FILE"
		
		ERROR_COUNT=$(grep -c "$PATTERN" "$LOG_FILE")
		echo $ERROR_COUNT >> "$REPORT_FILE"
		
		if [ "$ERROR_COUNT" -gt 10 ]; then
			echo -e "\n Action Required: to many $PATTERN issues in log file $LOG_FILE"
		fi
		
	done	
done

echo -e "\nLog analysis is completed and report saved in: $REPORT_FILE"
