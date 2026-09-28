#!/usr/bin/env bash
set -eu

FEATURE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#libusb-1.0-0 is for accessing a ledger
apt-get update && apt-get install -y vim bc libusb-1.0-0

su vscode -c "cat \"$FEATURE_DIR/bashrc-additions.sh\" >> ~/.bashrc"
