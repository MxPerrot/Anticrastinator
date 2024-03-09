# Paths
$BROWSER_PATH = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
$IDE_PATH = "C:\Users\unmax\AppData\Local\Programs\Microsoft VS Code\Code.exe"
$PROJECTS_DIR = "D:\git"
$MUSIC_DB = "./music.csv"

# Functions

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

    # Check if project path is specified
    if ($ProjectPath -ne "") {Start-Process -FilePath $IDE_PATH -ArgumentList $ProjectPath -NoNewWindow} 
    else {Write-Host "ERROR: No project path specified."}
}

# SELECT PROJECT
function Select-Project {
    # Check if projects directory exists
    if (Test-Path $PROJECTS_DIR) {
        # Get all subdirectories in projects directory
        $projects = Get-ChildItem -Path $PROJECTS_DIR -Directory

        # Check if there are any projects
        if ($projects.Count -gt 0) {
            # Display menu for selecting a project
            Write-Host "`nProjects"
            for ($i = 0; $i -lt $projects.Count; $i++) {
                Write-Host "$($i + 1). $($projects[$i].Name)"
            }

            # Prompt user for project selection
            $selection = Read-Host "`nSelect a project"

            # Validate user input
            if ($selection -ge 1 -and $selection -le $projects.Count) {
                $selectedProject = $projects[$selection - 1].Name
                $projectPath = Join-Path -Path $PROJECTS_DIR -ChildPath $selectedProject

                # Open the selected project in IDE
                return $projectPath
            } else {Write-Host "Invalid selection. Please try again.`n"}
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
            Write-Host "Musics"
            for ($i = 0; $i -lt $musics.Count; $i++) {
                Write-Host "$($i + 1). $($musics[$i].name)"
            }

            # Prompt user for music selection
            $selection = Read-Host "`nSelect a music"

            # Validate user input
            if ($selection -ne 0) {
                if ($selection -ge 1 -and $selection -le $musics.Count) {
                    $selectedMusic = $musics[$selection - 1]
                    $musicUrl = $selectedMusic.url

                    # Open the selected music in the browser
                    Open-Browser -musicUrl "https://www.youtube.com/watch?v=$musicUrl"
                } else {Write-Host "Invalid selection. Please try again.`n"}
            } else {Write-Host "No music selected.`n"}
        } else {Write-Host "No musics found in $MUSIC_DB`n"}
    } else {Write-Host "Music database not found. Path: $MUSIC_DB`n"}
}


# Main
function Main {
    $projectPath = Select-Project
    Select-Music
    Open-Project -project $projectPath
}

# Call the main function
Main

# End of script