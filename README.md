# audiodg-fixer
Powershell script that make the audiodg process running on a single core of the CPU to fix audio crackling

## How to use

1. Download the script
2. Run it as administrator

## How it works

The script will fetch the audiodg process and set its affinity to the last core of the CPU. This will fix the audio crackling issue on Windows computers.

## How to run it automatically

Make a new task that run the script with administrator privileges after voicemeeter started.
