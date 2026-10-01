# Log File Analyzer

A simple Bash script to automatically scan log files for `ERROR`, `FATAL`, and `WARN` entries, generate a summary report, and flag log files with a high number of issues.

## 📋 What It Does

This script:
- Scans a specified log directory for `.log` files that were **modified in the last 24 hours**
- Searches each log file for three severity patterns: `ERROR`, `FATAL`, and `WARN`
- Counts occurrences of each pattern per file
- Writes all matched lines and counts into a consolidated report file
- Flags (in terminal output) any file where a pattern occurs **more than 10 times**, indicating it may need attention

## 📁 Files

| File | Description |
|---|---|
| `analyze_log.sh` | The main Bash script |
| `log_analysis_report.txt` | Generated report (created automatically when the script runs) |

## ⚙️ Requirements

- A Linux/Unix environment with Bash
- Standard GNU utilities: `find`, `grep`

## 🚀 Usage

1. **Clone or download** this repository:
   ```bash
   git clone https://github.com/Pooja675/linuxProject.git
   cd linuxProject
   ```

2. **Make the script executable:**
   ```bash
   chmod +x analyze_log.sh
   ```

3. **Update the configuration** at the top of the script to match your environment:
   ```bash
   LOG_DIR="/home/pooja675/logs"
   REPORT_FILE="/home/pooja675/logs/log_analysis_report.txt"
   ```
   Replace the paths with the directory where your `.log` files are stored, and where you want the report saved.

4. **Run the script:**
   ```bash
   ./analyze_log.sh
   ```

5. **View the report:**
   ```bash
   cat /home/pooja675/logs/log_analysis_report.txt
   ```

## 🔍 How It Works

```bash
ERROR_PATTERNS=("ERROR" "FATAL" "WARN")
```
The script checks each log file against these three patterns, one at a time.

```bash
LOG_FILES=$(find $LOG_DIR -name "*.log" -mtime -1)
```
`-mtime -1` finds files modified within the last 1 day (24 hours), so the script only analyzes recently updated logs.

```bash
if [ "$ERROR_COUNT" -gt 10 ]; then
    echo -e "\n Action Required: too many $PATTERN issues in log file $LOG_FILE"
fi
```
If any pattern appears more than 10 times in a file, the script prints an "Action Required" alert to the terminal.

## 📄 Sample Report Output

```
Analysing log files
========================

 List of log files updated in last 24 hours
/home/pooja675/logs/system.log /home/pooja675/logs/application.log

Searching ERROR log in /home/pooja675/logs/application.log file
2026-09-10 10:05:12 ERROR Failed to connect to database: connection timeout
...

Number of ERROR log in /home/pooja675/logs/application.log file
11
```

## 🛠️ Possible Improvements

- Add a date/timestamp to each report run instead of overwriting the previous report
- Export results in CSV/JSON format for easier downstream analysis
- Add email/Slack notification when the "Action Required" threshold is triggered
- Make the `-mtime` window and the error-count threshold configurable via command-line flags
- Add a `set -euo pipefail` for stricter error handling

## 📚 Learning Context

This script was built as part of a Linux fundamentals and shell scripting learning journey, covering:
- Bash arrays and nested loops
- `find` with time-based filters
- `grep` pattern matching and counting
- Conditional logic and exit status handling
- Debugging common shell scripting pitfalls (spacing in `if` conditions, quoting variables)

## 📝 License

Free to use and modify for learning purposes.
