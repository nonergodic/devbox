#!/usr/bin/env bash
set -eu

FEATURE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

apt-get update && apt-get install -y vim bc

su vscode -c "cat \"$FEATURE_DIR/bashrc-additions.sh\" >> ~/.bashrc"
