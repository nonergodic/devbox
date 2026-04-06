#!/usr/bin/env bash
set -eu

su vscode -c 'pip install --user jupyter ipykernel numpy scipy pandas ipywidgets matplotlib plotly'
su vscode -c 'python3 -m ipykernel install --user --name python3'
