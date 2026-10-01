# backup1.sh - Backup Script with 5-Day Rotation

A simple Bash script that compresses a source folder into a timestamped `.zip` file and automatically keeps only the **5 most recent backups**, deleting older ones.

## Features

- Creates a zip backup of any folder (including subfolders)
- Names each backup with a unique timestamp
- Reports whether the backup succeeded
- Rotates backups: keeps the latest 5 and removes the rest

## Requirements

- Linux or macOS with Bash
- The `zip` utility

Install `zip` on Ubuntu/Debian if needed:

```bash
sudo apt install zip
```

## Installation

1. Save the script as `backup1.sh`.
2. Make it executable:

```bash
chmod +x backup1.sh
```

## Usage

```bash
./backup1.sh <path to your source> <path to backup folder>
```

| Argument | Description |
|----------|-------------|
| `<path to your source>` | The folder you want to back up |
| `<path to backup folder>` | The existing folder where zip files are stored |

### Example

```bash
./backup1.sh ~/projects/myapp ~/backups
```

Output:

```
Backup generated successfully for 2026-10-01-14-06-48
```

This creates `~/backups/backup_2026-10-01-14-06-48.zip`.

## How It Works

1. **Argument check:** shows the usage message if no arguments are given.
2. **Variables:** reads the source folder (`$1`), backup folder (`$2`), and the current timestamp (`YYYY-MM-DD-HH-MM-SS`).
3. **`create_backup`:** zips the source folder into `backup_<timestamp>.zip` and prints a success message if `zip` exits with status 0.
4. **`perform_rotation`:** lists all `backup_*.zip` files, newest first. If there are more than 5, it deletes everything after the 5th file.

## Backup Naming

```
backup_YYYY-MM-DD-HH-MM-SS.zip
```

Example: `backup_2026-10-01-14-06-48.zip`

## Rotation Example

If the backup folder holds 5 backups and you run the script again, a 6th backup is created and the oldest one is removed, leaving 5.

> **Warning:** Rotation permanently deletes files with `rm -f`. Only point the script at a backup folder that contains nothing but your backups.

## Scheduling with Cron

To run the backup automatically every day at 2:00 AM:

```bash
crontab -e
```

Add the line (use full paths):

```
0 2 * * * /home/youruser/backup1.sh /home/youruser/projects /home/youruser/backups
```

## Known Limitations

- If run with no arguments, the script prints usage but does not stop. Using `if [ $# -ne 2 ]` with `exit 1` would fix this.
- The backup folder must already exist; the script does not create it.
- Rotation works by file modification time and assumes filenames contain no spaces (true for the default names).
- Rotation runs even if the backup step failed.

## Possible Improvements

- Validate that the source and backup folders exist
- Make the number of backups to keep configurable
- Add logging to a file
- Add `set -u` to catch misspelled variables

## Author

Pooja
