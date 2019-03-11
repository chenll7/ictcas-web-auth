#!/bin/sh

logout (){
    printf "Logout with phantomjs ...\n"
    timeout -s 2 10 phantomjs --ignore-ssl-errors=true logout.js
    printf "Logout operation finished.\n"
}

ARGS=`getopt -o u:p: --long username:,password: -- "$@"` || exit 1

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
    logout
else
    printf "Warning: username or password is not set.Terminating ...\n"
fi