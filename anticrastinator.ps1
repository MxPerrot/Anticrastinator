# Paths to the applications
$browser_path = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
$vscode_path = "C:\Users\unmax\AppData\Local\Programs\Microsoft VS Code\Code.exe"

# Music and project
# TODO: Make a music & project selector
$music = "RRudInesh5M"
$project = "sae34_2c4"

# Paths to the project and music
$project_path = "D:\git\$project"
$music_url = "https://www.youtube.com/watch?v=$music"

# Check if Brave is installed
if (Test-Path $browser_path) {
    # Open Brave with the specified URL
    Start-Process -FilePath $browser_path -ArgumentList $music_url
} else {
    Write-Host "ERROR: Browser not found. Path: $browser_path"
}

# Check if project is specified
if ($project -ne "") { 
    # Open the project in VS Code
    Start-Process -FilePath $vscode_path -ArgumentList $project_path
} else {
    Write-Host "ERROR: No project specified. Path: $project_path"
}

