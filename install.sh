#!/bin/bash
# specops installer for Cursor (macOS/Linux)
# Installs skills and agents to ~/.cursor/

set -e

VERSION="v2.3.0"
CURSOR_DIR="$HOME/.cursor"
SKILLS_DIR="$CURSOR_DIR/skills/specops"
AGENTS_DIR="$CURSOR_DIR/agents"
REPO_RAW="https://raw.githubusercontent.com/wilddeer/specops/$VERSION"

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

status() {
    echo -e "${CYAN}[specops]${NC} $1"
}

success() {
    echo -e "${GREEN}[specops]${NC} $1"
}

error() {
    echo -e "${RED}[specops]${NC} $1"
}

# Check if Cursor directory exists
if [ ! -d "$CURSOR_DIR" ]; then
    error "Cursor directory not found at $CURSOR_DIR"
    error "Please install Cursor first: https://cursor.com"
    exit 1
fi

# Clean previous installation
if [ -d "$SKILLS_DIR" ]; then
    status "Removing previous skills installation..."
    rm -rf "$SKILLS_DIR"
fi

# Note: Not cleaning agents dir since it's shared with other plugins

# Create directories
status "Creating directories..."
mkdir -p "$SKILLS_DIR/spec-driven-work"
mkdir -p "$SKILLS_DIR/spec-step-execution"
mkdir -p "$AGENTS_DIR"  # Creates if not exists, no-op otherwise

# Download function
download() {
    local url="$1"
    local dest="$2"

    if command -v curl &> /dev/null; then
        curl -fsSL "$url" -o "$dest"
        return $?
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$dest"
        return $?
    else
        error "Neither curl nor wget found. Please install one of them."
        exit 1
    fi
}

# Download skills
status "Downloading skills..."

for skill in "spec-driven-work" "spec-step-execution"; do
    url="$REPO_RAW/skills/$skill/SKILL.md"
    dest="$SKILLS_DIR/$skill/SKILL.md"
    
    if download "$url" "$dest"; then
        success "  Downloaded $skill"
    else
        error "  Failed to download $skill"
        exit 1
    fi
done

# Download agents
status "Downloading agents..."

for agent in "spec-step-executor.md"; do
    url="$REPO_RAW/agents/$agent"
    dest="$AGENTS_DIR/$agent"
    
    if download "$url" "$dest"; then
        success "  Downloaded $agent"
    else
        error "  Failed to download $agent"
        exit 1
    fi
done

echo ""
success "Installation complete!"
echo ""
echo -e "${WHITE}Installed to:${NC}"
echo -e "${GRAY}  Skills: $SKILLS_DIR${NC}"
echo -e "${GRAY}  Agents: $AGENTS_DIR${NC}"
echo ""
echo -e "${WHITE}To uninstall:${NC}"
echo -e "${GRAY}  rm -rf '$SKILLS_DIR'${NC}"
echo -e "${GRAY}  rm '$AGENTS_DIR/spec-step-executor.md'${NC}"
