# Anticrastinator

This PowerShell script helps you work by opening a project in your IDE and playing some music.
It will prompt you to select a project and music from your database.

If this is your first time running this script, please **make sure to configure the paths** in the beginning of the script

## Install

1. Clone this repository to your machine
2. Edit the paths at the beginning of `anticrastinator.ps1`
3. Creating an icon on your Desktop
    - Right-click `anticrastinator.ps1` in your file explorer
    - Click on `Send to`
    - Click on `Desktop (link)`
    - Double-click the icon you just created on your desktop
    - Run it using Powershell. Remember to check `use this every time []`
    
## Add your own music

To add your own music, open the `music.csv` file using a text editor and add a row for each music following this format: `name, youtube-identifier`

> e.g. I want to add this music
> 
> Lindsey Stirling - Roundtable Rival (Official Music Video)
> 
> `https://www.youtube.com/watch?v=jvipPYFebWc`
>
> The shortened youtube URL is the string of characters after the `=`. here it is `jvipPYFebWc`
> 
> Therefore I add `Lindsey Stirling - Roundtable Rival,jvipPYFebWc` at the end of `music.csv`
