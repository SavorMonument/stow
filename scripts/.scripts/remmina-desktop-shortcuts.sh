#!/usr/bin/env bash

REM_MINA_DIR="$HOME/.local/share/remmina"
DESKTOP_DIR="$HOME/Desktop"

mkdir -p "$DESKTOP_DIR"

for FILE in "$REM_MINA_DIR"/*.remmina; do
    [ -e "$FILE" ] || continue

    # Extract values from the remmina config
    NAME=$(grep -m1 '^name=' "$FILE" | cut -d= -f2)
    SERVER=$(grep -m1 '^server=' "$FILE" | cut -d= -f2)
    PROTOCOL=$(grep -m1 '^protocol=' "$FILE" | cut -d= -f2)

    # Fallbacks
    NAME=${NAME:-$(basename "$FILE" .remmina)}
    PROTOCOL=${PROTOCOL:-rdp}

    # Sanitize filename
    SAFE_NAME=$(echo "$NAME" | tr ' /' '__')

    DESKTOP_FILE="$DESKTOP_DIR/Remmina_${SAFE_NAME}.desktop"

    cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$NAME
Comment=Remmina connection to $SERVER
Exec=remmina -c "$FILE"
Icon=remmina
Terminal=false
Categories=Network;RemoteAccess;
EOF

    chmod +x "$DESKTOP_FILE"

    echo "Created: $DESKTOP_FILE"
done
