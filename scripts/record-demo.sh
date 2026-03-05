#!/bin/bash
# Record a demo GIF of Agent-O
# Prerequisites: brew install ffmpeg gifsicle
# Usage: ./scripts/record-demo.sh

echo "=== Agent-O Demo Recorder ==="
echo ""
echo "This will record your screen for 30 seconds and create a GIF."
echo "1. Start Agent-O first: ./run.sh"
echo "2. Position the Agent-O window where you want it"
echo "3. Press Enter to start recording"
echo ""
read -p "Press Enter to start recording (30 seconds)..."

OUTPUT_DIR="$(dirname "$0")/.."
TIMESTAMP=$(date +%s)
VIDEO="/tmp/agento-demo-${TIMESTAMP}.mov"
GIF="${OUTPUT_DIR}/assets/demo.gif"

echo "Recording for 30 seconds... (Cmd+C to stop early)"
screencapture -v -V 30 -R 0,0,500,600 "$VIDEO" 2>/dev/null

if [ ! -f "$VIDEO" ]; then
    echo "Recording cancelled or failed."
    exit 1
fi

echo "Converting to GIF..."
if command -v ffmpeg &>/dev/null; then
    ffmpeg -i "$VIDEO" -vf "fps=10,scale=500:-1:flags=lanczos" -y /tmp/agento-demo.gif 2>/dev/null
    if command -v gifsicle &>/dev/null; then
        gifsicle --optimize=3 --colors 128 /tmp/agento-demo.gif -o "$GIF"
    else
        mv /tmp/agento-demo.gif "$GIF"
    fi
    rm -f "$VIDEO" /tmp/agento-demo.gif
    echo ""
    echo "Done! GIF saved to: assets/demo.gif"
    echo "File size: $(du -h "$GIF" | cut -f1)"
    echo ""
    echo "To add to README, the image tag is already there."
    echo "Just commit and push: git add assets/demo.gif && git push"
else
    echo "ffmpeg not found. Install with: brew install ffmpeg"
    echo "Raw video saved at: $VIDEO"
fi
