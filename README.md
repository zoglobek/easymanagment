Easy Management (easy\_manager.sh)



Easy Management is an interactive Text User Interface (TUI) Bash script designed to simplify routine Linux system administration tasks. It acts as an all-in-one control panel for user management, backups, file manipulation, system updates, monitoring, and remote SSH operations.

Features

1\. User Management Menu



&#x20;   Add User: Creates a new system user with duplicate validation.



&#x20;   Delete User: Safely deletes a user and their home directory (userdel -r).



&#x20;   Lock/Unlock User: Temporarily disables or re-enables user account access (usermod -L / usermod -U).



&#x20;   Script Run Permissions: Automatically sets up a dedicated script\_group and grants passwordless sudo execution rights to a designated script via /etc/sudoers.d/.



2\. Backup Master



&#x20;   Target Selection: Define the full path of a file or directory to target.



&#x20;   Gzip Compression: Compress selected files using gzip -k.



&#x20;   Archiving: Bundle directories using tar.



&#x20;   Backup Execution: Copy target backups directly to /backup.



3\. File Manipulation Menu



&#x20;   Create File: Quickly create new files with or without full paths.



&#x20;   Edit File: Open and edit files using nano.



&#x20;   Make Executable: Grant execution permissions (chmod +x) to scripts or binaries.



&#x20;   Display Content: Print file contents directly to the terminal (cat).



4\. General Commands Menu



&#x20;   Update \& Upgrade: Refresh package lists (apt update) and upgrade the system (apt upgrade).



&#x20;   Cleanup: Remove orphaned or unneeded packages (apt autoremove).



&#x20;   Package Management: Purge or install specific packages seamlessly.



5\. Monitoring Menu



&#x20;   Process Viewer: Inspect active processes via ps aux.



&#x20;   Resource Usage: Launch htop for real-time CPU and memory tracking.



&#x20;   Log Inspection: Quickly view the last 20 lines of system logs (syslog, journalctl), or filter kernel warning/error logs (dmesg).



6\. Remote Options Menu



&#x20;   SSH \& SCP Client: Connect to remote servers or transfer files easily.



&#x20;   Known Hosts Tracker: Automatically logs and manages a history of connected remote targets in \~/.ssh/hostlog.



&#x20;   SSH Key Management: Generate 4096-bit RSA keys and distribute them to remote hosts (ssh-copy-id).



&#x20;   Cron Management: Quickly open and edit the current user's crontab.



Security \& Logging



&#x20;   Root Privileges Required: The script enforces execution through sudo or root to ensure administrative tasks succeed.



&#x20;   Audit Trail: Every action executed through the menus is logged with timestamps and user details into /root/scr2.log.



&#x20;   Host Log Integrity: Automatically checks and secures hostlog file permissions (600) to prevent unauthorized tampering.



Requirements



&#x20;   Linux-based OS (Debian/Ubuntu-based recommended due to apt usage).



&#x20;   sudo privileges.



&#x20;   Standard core utilities (tar, gzip, nano, htop, ssh).



Usage



&#x20;   Clone or download the script to your local machine.



&#x20;   Make the script executable:

&#x20;   Bash



&#x20;   chmod +x easy\_manager.sh



&#x20;   Run the script using sudo:

&#x20;   Bash



&#x20;   sudo ./easy\_manager.sh



Created by Gal Newman

