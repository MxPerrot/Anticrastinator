#########
# Paths #
#########

$BROWSER_PATH = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" # Path to your browser (USE YOUR OWN PATH)
$IDE_PATH = "C:\Users\unmax\AppData\Local\Programs\Microsoft VS Code\Code.exe" # Path to your IDE (USE YOUR OWN PATH)
$PROJECTS_DIR = "D:\git" # Path to the directory where your projects are stored (USE YOUR OWN PATH)
$MUSIC_DB = "./music.csv" # Path to the music database (KEEP THE DEFAULT PATH)

#############
# Functions #
#############

# DISPLAY INFO

function Info {
    Write-Host "ANTICRASTINATOR"
    Write-Host "---------------`n"
}

# OPEN MUSIC IN BROWSER
function Open-Browser {
    param (
        [Parameter(Mandatory=$true)]
        [string]$musicUrl
    )

    if (Test-Path $BROWSER_PATH) {Start-Process -FilePath $BROWSER_PATH -ArgumentList $musicUrl}
    else {Write-Host "ERROR: Browser not found. Path: $BROWSER_PATH"}
}

# OPEN PROJECT IN IDE
function Open-Project {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ProjectPath
    )

    if ($ProjectPath -ne "") {Start-Process -FilePath $IDE_PATH -ArgumentList $ProjectPath -NoNewWindow} 
    else {Write-Host "ERROR: No project path specified."}
}

# SELECT PROJECT
function Select-Project {

    if (Test-Path $PROJECTS_DIR) { # Check if projects directory exists
        $projects = Get-ChildItem -Path $PROJECTS_DIR -Directory

        if ($projects.Count -gt 0) { # Check if there are any projects
            # Display menu for selecting a project
            Write-Host "`nProjects"
            for ($i = 0; $i -lt $projects.Count; $i++) {
                Write-Host "$($i + 1). $($projects[$i].Name)"
            }

            do {
                $selection = Read-Host "`nSelect a project"

                if ($selection -ge 1 -and $selection -le $projects.Count) {
                    $selectedProject = $projects[$selection - 1].Name
                    $projectPath = Join-Path -Path $PROJECTS_DIR -ChildPath $selectedProject

                    return $projectPath
                } else {
                    Write-Host "Invalid selection. Please try again.`n"
                }
            } while ($true)
            
        } else {Write-Host "No projects found in $PROJECTS_DIR`n"}
    } else {Write-Host "Projects directory not found. Path: $PROJECTS_DIR`n"}
}

# SELECT MUSIC
function Select-Music {
    # Check if music database exists
    if (Test-Path $MUSIC_DB) {
        # Read music database
        $musics = Import-Csv -Path $MUSIC_DB

        # Check if there are any musics
        if ($musics.Count -gt 0) {
            # Display menu for selecting a music
            Write-Host "`nMusics"
            Write-Host "0. NO MUSIC"
            for ($i = 0; $i -lt $musics.Count; $i++) {
                Write-Host "$($i + 1). $($musics[$i].name)"
            }

            do {
                # Prompt user for music selection
                $selection = Read-Host "`nSelect a music"

                # Validate user input
                if ($selection -ge 0 -and $selection -le $musics.Count) {
                    if ($selection -ne 0) {
                        $selectedMusic = $musics[$selection - 1]
                        $musicUrl = $selectedMusic.url

                        # Open the selected music in the browser
                        Open-Browser -musicUrl "https://www.youtube.com/watch?v=$musicUrl"
                    }
                } else {
                    Write-Host "Invalid selection. Please try again.`n"
                }
            } while ($selection -lt 0 -or $selection -gt $musics.Count)
        } else {Write-Host "No musics found in $MUSIC_DB`n"}
    } else {Write-Host "Music database not found. Path: $MUSIC_DB`n"}
}

########
# MAIN #
########
function Main {
    Info
    $projectPath = Select-Project
    Select-Music
    Open-Project -project $projectPath
}

# Call the main function
Main
