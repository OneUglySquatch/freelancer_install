#!/bin/bash
set -euo pipefail

clear

#####################################
# CONFIG
#####################################

PREFIX="$HOME/Freelancer"
DISCOVERY="$HOME/Downloads/discovery_5.3.2.exe"
LOG="$HOME/discovery_install.log"

LAUNCHER_DIR="$HOME/Freelancer/drive_c/users/$USER/AppData/Local/Discovery Freelancer 5.3.2"

export WINEPREFIX="$PREFIX"

#####################################
# LOGGING
#####################################

exec > >(tee -a "$LOG") 2>&1
echo
echo "================================================"
echo " Discovery Installer"
echo "================================================"
echo

#####################################
# PRE-FLIGHT CHECKS
#####################################
echo
echo "=== Checking required files ==="
echo
if [ ! -f "$DISCOVERY" ]; then
    echo "ERROR: Discovery installer not found at:"
    echo "$DISCOVERY"
    exit 1
fi
echo
echo "OK: Discovery installer found"
echo
#####################################
# INSTALL DISCOVERY MOD
#####################################
echo
echo "=== Installing Discovery Freelancer 5.3.2 ==="
echo
wine "$DISCOVERY"
echo
echo "Waiting for Wine to fully exit..."
echo
#####################################
# VERIFY INSTALL
#####################################

if [ ! -d "$LAUNCHER_DIR" ]; then
    echo
    echo "ERROR: Discovery launcher folder not found:"
    echo "$LAUNCHER_DIR"
    echo "Installation may have failed."
    echo
    exit 1
fi

LAUNCHER_EXE="$LAUNCHER_DIR/DSLauncher.exe"

if [ ! -f "$LAUNCHER_EXE" ]; then
    echo
    echo "ERROR: DSLauncher.exe not found"
    echo
    exit 1
fi

#####################################
# LAUNCH
#####################################
echo
echo "=== Starting Discovery Launcher ==="
echo
echo "================================================"
echo " INSTALL COMPLETE"
echo "================================================"
echo "Wine Prefix: $PREFIX"
echo "Launcher: $LAUNCHER_DIR"
echo "Log: $LOG"
echo
echo "Future launch command:"
echo "cd \"$LAUNCHER_DIR\" && wine DSLauncher.exe"
echo "================================================"
