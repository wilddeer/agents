# specops installer for Cursor (Windows)
# Installs skills and agents to ~/.cursor/

$ErrorActionPreference = "Stop"

$VERSION = "v4.1.0"
$CURSOR_DIR = "$HOME\.cursor"
$SKILLS_DIR = "$CURSOR_DIR\skills\specops"
$AGENTS_DIR = "$CURSOR_DIR\agents"
$REPO_RAW = "https://raw.githubusercontent.com/wilddeer/specops/$VERSION"

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

# Note: Not cleaning agents dir since it's shared with other plugins

# Create directories
Write-Status "Creating directories..."
New-Item -ItemType Directory -Force -Path "$SKILLS_DIR\spec-development" | Out-Null
New-Item -ItemType Directory -Force -Path "$SKILLS_DIR\spec-development\assets" | Out-Null
New-Item -ItemType Directory -Force -Path "$SKILLS_DIR\spec-execution" | Out-Null
New-Item -ItemType Directory -Force -Path "$SKILLS_DIR\spec-execution\assets" | Out-Null
New-Item -ItemType Directory -Force -Path "$SKILLS_DIR\spec-step-execution" | Out-Null
New-Item -ItemType Directory -Force -Path "$SKILLS_DIR\spec-step-review" | Out-Null
if (-not (Test-Path $AGENTS_DIR)) {
    New-Item -ItemType Directory -Force -Path $AGENTS_DIR | Out-Null
}

# Download skills
Write-Status "Downloading skills..."

$skills = @(
    @{ name = "spec-development"; file = "SKILL.md" },
    @{ name = "spec-execution"; file = "SKILL.md" },
    @{ name = "spec-step-execution"; file = "SKILL.md" },
    @{ name = "spec-step-review"; file = "SKILL.md" }
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

# Download assets for spec-development
Write-Status "Downloading spec-development assets..."

$devAssets = @(
    "research-template.md",
    "spec-template.md"
)

foreach ($asset in $devAssets) {
    $url = "$REPO_RAW/skills/spec-development/assets/$asset"
    $dest = "$SKILLS_DIR\spec-development\assets\$asset"

    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        Write-Success "  Downloaded spec-development/assets/$asset"
    } catch {
        Write-Error "  Failed to download spec-development/assets/${asset}: $_"
        exit 1
    }
}

# Download assets for spec-execution
Write-Status "Downloading spec-execution assets..."

$execAssets = @(
    "progress-template.md"
)

foreach ($asset in $execAssets) {
    $url = "$REPO_RAW/skills/spec-execution/assets/$asset"
    $dest = "$SKILLS_DIR\spec-execution\assets\$asset"

    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        Write-Success "  Downloaded spec-execution/assets/$asset"
    } catch {
        Write-Error "  Failed to download spec-execution/assets/${asset}: $_"
        exit 1
    }
}

# Download agents
Write-Status "Downloading agents..."

$agents = @(
    "spec-step-executor.md",
    "spec-step-reviewer.md"
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
Write-Host "To uninstall:" -ForegroundColor White
Write-Host "  Remove-Item -Recurse -Force '$SKILLS_DIR'" -ForegroundColor Gray
Write-Host "  Remove-Item '$AGENTS_DIR\spec-step-executor.md'" -ForegroundColor Gray
Write-Host "  Remove-Item '$AGENTS_DIR\spec-step-reviewer.md'" -ForegroundColor Gray
