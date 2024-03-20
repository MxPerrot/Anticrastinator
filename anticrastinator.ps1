#############################################
#                 CONSTANTS                 #
#############################################

# PATHS (USE YOUR OWN PATHS)                 
Set-Variable -Name "PATH_BROWSER"       -Value "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" -Option Constant # Path to your browser (USE YOUR OWN PATH)
Set-Variable -Name "PATH_IDE"           -Value "C:\Users\unmax\AppData\Local\Programs\Microsoft VS Code\Code.exe"   -Option Constant # Path to your IDE (USE YOUR OWN PATH)
Set-Variable -Name "PROJECTS_DIR"       -Value "D:\git"                                                             -Option Constant # Path to the directory where your projects are stored (USE YOUR OWN PATH)
Set-Variable -Name "MUSIC_DB"           -Value "./private_music.csv"                                                -Option Constant # Path to the music database (USE YOUR OWN PATH, PREFERABLY TO music.csv)

# URLS
Set-Variable -Name "YOUTUBE_BASE_URL"   -Value "https://www.youtube.com/watch?v="                                   -Option Constant

# INFO
Set-Variable -Name "TITLE" -Value "ANTICRASTINATOR`n---------------`n" -Option Constant

# PROMPTS
Set-Variable -Name "PROMPT_SELECT_PROJECT"  -Value "Select a project"   -Option Constant
Set-Variable -Name "PROMPT_SELECT_MUSIC"    -Value "Select a music"     -Option Constant

# ERRORS
Set-Variable -Name "ERROR_INVALID_SELECTION"            -Value "ERROR: Invalid selection. Please try again."                -Option Constant
Set-Variable -Name "ERROR_PROJECT_PATH_NOT_SPECIFIED"   -Value "ERROR: No project path specified."                          -Option Constant
Set-Variable -Name "ERROR_PROJECTS_DIR_NOT_FOUND"       -Value "ERROR: Projects directory not found. Path: $PROJECTS_DIR"   -Option Constant
Set-Variable -Name "ERROR_NO_PROJECTS_FOUND"            -Value "ERROR: No projects found in $PROJECTS_DIR"                  -Option Constant
Set-Variable -Name "ERROR_BROWSER_NOT_FOUND"            -Value "ERROR: Browser not found. Path: $PATH_BROWSER"              -Option Constant
Set-Variable -Name "ERROR_MUSIC_DB_NOT_FOUND"           -Value "ERROR: Music database not found. Path: $MUSIC_DB"           -Option Constant
Set-Variable -Name "ERROR_NO_MUSICS_FOUND"              -Value "ERROR: No musics found in $MUSIC_DB"                        -Option Constant

#############################################
#                 FUNCTIONS                 #
#############################################

# DISPLAY INFO

function Info {
    # Print the Title constant
    Write-Host $TITLE
}

# OPEN MUSIC IN BROWSER
function Open-Browser {
    param (
        [Parameter(Mandatory=$true)]
        [string]$musicUrl
    )

    if (Test-Path $PATH_BROWSER) {Start-Process -FilePath $PATH_BROWSER -ArgumentList $musicUrl}
    else {Write-Host $ERROR_BROWSER_NOT_FOUND}
}

# OPEN PROJECT IN IDE
function Open-Project {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ProjectPath
    )

    if ($ProjectPath -ne "") {Start-Process -FilePath $PATH_IDE -ArgumentList $ProjectPath -NoNewWindow} 
    else {Write-Host $ERROR_PROJECT_PATH_NOT_SPECIFIED}	
}

# SELECT PROJECT
function Select-Project {

    if (Test-Path $PROJECTS_DIR) { # Check if projects directory exists
        $projects = Get-ChildItem -Path $PROJECTS_DIR -Directory
        $projectsCount = $projects.Count
        if ($projectsCount -gt 0) { # Check if there are any projects
            
            Write-Host "$projectsCount projects found in $PROJECTS_DIR`n"

            # Display menu for selecting a project
            Write-Host "`nProjects"
            for ($i = 0; $i -lt $projectsCount; $i++) {
                Write-Host "$($i + 1). $($projects[$i].Name)"
            }

            do {
                # Prompt user for project selection
                [int]$selection = Read-Host $PROMPT_SELECT_PROJECT

                # Validate user input
                if ($selection -ge 1 -and $selection -le $projectsCount) {
                    
                    $selectedProject = $projects[$selection - 1].Name
                    $projectPath = Join-Path -Path $PROJECTS_DIR -ChildPath $selectedProject

                    Write-Host "Selected project: $selectedProject`n"
                    return $projectPath
                } else {
                    Write-Host $ERROR_INVALID_SELECTION
                }
            } while ($true)
        } else {Write-Host $ERROR_NO_PROJECTS_FOUND}
    } else {Write-Host $ERROR_PROJECTS_DIR_NOT_FOUND}
}

# SELECT MUSIC
function Select-Music {
    if (Test-Path $MUSIC_DB) {# Check if music database exists
        $musics = Import-Csv -Path $MUSIC_DB
        $musicsCount = $musics.Count

        if ($musicsCount -gt 0) {# Check if there are any musics

        # Check if there are any musics
        if ($musics.Count -gt 0) {
            # Display menu for selecting a music
            Write-Host "`nMusics"
            Write-Host "0. NO MUSIC"
            for ($i = 0; $i -lt $musicsCount; $i++) {
                Write-Host "$($i + 1). $($musics[$i].name)"
            }

            do {
                # Prompt user for music selection
                [int]$selection = Read-Host $PROMPT_SELECT_MUSIC

                # Validate user input
                if ($selection -ge 0 -and $selection -le $musicsCount) {
                    Write-Host "Selection: $selection"
                    if ($selection -ne 0) {
                        $selectedMusic = $musics[$selection - 1]
                        $musicUrl = $selectedMusic.url

                        # Open the selected music in the browser
                        return "$YOUTUBE_BASE_URL$musicUrl"
                    }
                } else {
                    Write-Host $ERROR_INVALID_SELECTION
                }
            } while ($selection -lt 0 -or $selection -gt $musicsCount)
        } else {Write-Host $ERROR_NO_MUSICS_FOUND}
    } else {Write-Host $ERROR_MUSIC_DB_NOT_FOUND}
}

#############################################
#                    MAIN                   #
#############################################

function Main {
    Info
    $projectPath = Select-Project
    Select-Music
    Open-Project -project $projectPath
}

# Call the main function
Main
