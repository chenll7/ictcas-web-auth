#!/bin/sh

check_online () {
    echo "Ping baidu to check if it is online."
    ping -c 1 www.baidu.com >/dev/null 2>&1
}

login () {
    printf "Start ...\n"
    check_online && { printf "Online now.\n";return 0; }
    echo "It is offline!"
    for i in $(seq 0 1);do
        printf "Login with phantomjs ...\n"
        printf "******************\n"
        timeout -s 2 10 phantomjs --ignore-ssl-errors=true login.js
        printf "******************\n"
        printf "Login operation finished.\n"
        check_online && { printf "Online now.\n";return 0; }
        printf "Still offline.\n"
        if [ $FORCE_MODE -eq 1 ];then
            printf "Perhaps the online IPs are full. Try to log them out.\n"
            printf "Logout with phantomjs ...\n"
            printf "******************\n"
            timeout -s 2 10 phantomjs --ignore-ssl-errors=true logout.js
            printf "******************\n"
            printf "Logout operation finished.\n"
        fi
    done
    if [ $FORCE_MODE -eq 1 ];then
        printf "Try many times but sill fail。Possible reason: Wrong username or password.\n"
    else
        printf "Try many times but sill fail。Possible reason: (1) Wrong username or password. (2) Online IPs are full. You can try to run logout.sh to log them out.\n"
    fi
    return 1
}

INTERVAL_MODE=0
FORCE_MODE=0

ARGS=`getopt -o u:p: --long username:,password:,interval,force -- "$@"` || exit 1

eval set -- "${ARGS}"

while true;do
    case "$1" in
        -u|--username)
            printf "Username is '$2'.\n";
            export USERNAME=$2
            shift 2
            ;;
        -p|--password)
            printf "Password is '$2'.\n";
            export PASSWD=$2
            shift 2
            ;;
        --interval)
            printf "Interval mode.\n";
            INTERVAL_MODE=1
            shift
            ;;
        --force)
            printf "Force mode (if online IP is full, force them to be offline ).\n";
            FORCE_MODE=1
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Error!"
            exit 1
            ;;
    esac
done
if [ -n "$USERNAME" -a -n "$PASSWD" ];then
    if [ $INTERVAL_MODE -eq 1 ];then
        while true;do
            login
            printf "Sleep 180s ...\n"
            sleep 180s
        done
    else
        login
    fi
else
    printf "Warning: username or password is not set.Terminating ...\n"
fi

printf "Program exit.\n"