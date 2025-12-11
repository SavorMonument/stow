#!/bin/bash

PIDFILE="/tmp/openfortivpn.pid"

case "$1" in
    start)
        if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
            echo "OpenFortiVPN is already running"
            exit 1
        fi
        echo "Starting OpenFortiVPN..."
        # Run in background and save PID
        nohup sudo openfortivpn --saml-login vpn.sia.utcluj.ro 2>&1 &
        echo $! > "$PIDFILE"
        /usr/bin/chromium --profile-directory="Default" https://vpn.sia.utcluj.ro:443/remote/saml/start?redirect=1
        ;;
    stop)
        if [ ! -f "$PIDFILE" ]; then
            echo "No running OpenFortiVPN found"
            exit 1
        fi
        PID=$(cat "$PIDFILE")
        echo "Stopping OpenFortiVPN (PID $PID)..."
        sudo kill $PID
        rm -f "$PIDFILE"
        ;;
    restart)
        $0 stop
        sleep 1
        $0 start
        ;;
    status)
        if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
            echo "OpenFortiVPN is running (PID $(cat $PIDFILE))"
        else
            echo "OpenFortiVPN is not running"
        fi
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac
