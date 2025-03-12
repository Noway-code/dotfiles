#!/bin/bash

set -e

if ! command -v alacritty &> /dev/null
then
    echo "Alacritty could not be found. Please install it and ensure it's in your PATH."
    exit 1
fi

# Launch backend terminal
alacritty -e bash -c '
set -e
cd /home/noarchway/Code/TypeAlongSvelte
source venv/bin/activate
cd backend
uvicorn app.main:app --reload
exec bash
' &

# Launch frontend terminal
alacritty -e bash -c '
set -e
cd /home/noarchway/Code/TypeAlongSvelte
npm run dev -- --open
exec bash
' &

exit 1
