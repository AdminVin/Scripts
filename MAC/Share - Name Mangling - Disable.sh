# By default, macOS uses SMB (Server Message Block) version 2 or 3 for file sharing with Windows computers, and it enables "name mangling" to ensure compatibility with older versions of SMB used by some Windows clients. Name mangling replaces certain characters in filenames with underscores, which can cause issues with file names that are shared between macOS and Windows.

Terminal
sudo nano /etc/nsmb.conf
Edit file to include:

[default]
streams=no

________________

Control + O (to save changes)
Control + X (to close editor)
Reboot