#!/usr/bin/env bash
set -eu

su vscode -c 'pip install --user jupyter ipykernel numpy ipywidgets scipy matplotlib'
su vscode -c 'python3 -m ipykernel install --user --name python3'
