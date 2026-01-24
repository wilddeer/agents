# specops installer for Cursor (Windows)
# Installs skills and agents to ~/.cursor/
# Usage: .\install.ps1 [version]
#   .\install.ps1         # Install latest release
#   .\install.ps1 v2.2.0  # Install specific version
# Note: When run via "irm ... | iex", always installs latest release

$ErrorActionPreference = "Stop"

# Get version from argument (only works when run as script file, not via iex)
if ($args.Count -gt 0) {
    $Version = $args[0]
} else {
    $Version = "latest"
}

$CURSOR_DIR = "$HOME\.cursor"
$SKILLS_DIR = "$CURSOR_DIR\skills\specops"
$AGENTS_DIR = "$CURSOR_DIR\agents\specops"

# Fetch latest release version if not specified
if ($Version -eq "latest") {
    try {
        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/wilddeer/specops/releases/latest" -UseBasicParsing
        $Version = $release.tag_name
    } catch {
        Write-Host "[specops] Failed to fetch latest release version from GitHub API: $_" -ForegroundColor Red
        exit 1
    }

    if ([string]::IsNullOrEmpty($Version)) {
        Write-Host "[specops] Failed to fetch latest release version from GitHub API" -ForegroundColor Red
        exit 1
    }
}

$REPO_RAW = "https://raw.githubusercontent.com/wilddeer/specops/$Version"

function Write-Status($message) {
    Write-Host "[specops] $message" -ForegroundColor Cyan
}

function Write-Success($message) {
    Write-Host "[specops] $message" -ForegroundColor Green
}

function Write-Error($message) {
    Write-Host "[specops] $message" -ForegroundColor Red
}

# Check if Cursor directory exists
if (-not (Test-Path $CURSOR_DIR)) {
    Write-Error "Cursor directory not found at $CURSOR_DIR"
    Write-Error "Please install Cursor first: https://cursor.com"
    exit 1
}

# Clean previous installation
if (Test-Path $SKILLS_DIR) {
    Write-Status "Removing previous skills installation..."
    Remove-Item -Recurse -Force $SKILLS_DIR
}

if (Test-Path $AGENTS_DIR) {
    Write-Status "Removing previous agents installation..."
    Remove-Item -Recurse -Force $AGENTS_DIR
}

# Create directories
Write-Status "Creating directories..."
New-Item -ItemType Directory -Force -Path "$SKILLS_DIR\spec-driven-work" | Out-Null
New-Item -ItemType Directory -Force -Path "$SKILLS_DIR\spec-step-execution" | Out-Null
New-Item -ItemType Directory -Force -Path $AGENTS_DIR | Out-Null

# Download skills
Write-Status "Downloading skills..."

$skills = @(
    @{ name = "spec-driven-work"; file = "SKILL.md" },
    @{ name = "spec-step-execution"; file = "SKILL.md" }
)

foreach ($skill in $skills) {
    $url = "$REPO_RAW/skills/$($skill.name)/$($skill.file)"
    $dest = "$SKILLS_DIR\$($skill.name)\$($skill.file)"
    
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        Write-Success "  Downloaded $($skill.name)"
    } catch {
        Write-Error "  Failed to download $($skill.name): $_"
        exit 1
    }
}

# Download agents
Write-Status "Downloading agents..."

$agents = @(
    "spec-step-executor.md"
)

foreach ($agent in $agents) {
    $url = "$REPO_RAW/agents/$agent"
    $dest = "$AGENTS_DIR\$agent"
    
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        Write-Success "  Downloaded $agent"
    } catch {
        Write-Error "  Failed to download ${agent}: $_"
        exit 1
    }
}

Write-Host ""
Write-Success "Installation complete!"
Write-Host ""
Write-Host "Installed to:" -ForegroundColor White
Write-Host "  Skills: $SKILLS_DIR" -ForegroundColor Gray
Write-Host "  Agents: $AGENTS_DIR" -ForegroundColor Gray
Write-Host ""
Write-Host "To uninstall, remove these folders:" -ForegroundColor White
Write-Host "  Remove-Item -Recurse -Force '$SKILLS_DIR'" -ForegroundColor Gray
Write-Host "  Remove-Item -Recurse -Force '$AGENTS_DIR'" -ForegroundColor Gray
