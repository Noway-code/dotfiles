#!/bin/bash
printf "Restoring virtual environment...\n"
if [ -f "$PWD/.venv/bin/activate" ]; then
  source "$PWD/.venv/bin/activate"
elif [ -f "$PWD/venv/bin/activate" ]; then
  source "$PWD/venv/bin/activate"
elif [ -f "$PWD/myenv/bin/activate" ]; then
  source "$PWD/myenv/bin/activate"
elif [ -f "$PWD/env/bin/activate" ]; then
  source "$PWD/env/bin/activate"
elif [ -f "$PWD/.env/bin/activate" ]; then
  source "$PWD/.env/bin/activate"
fi

