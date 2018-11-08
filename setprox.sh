#!/bin/bash

PROXY="${@: -1}"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --http)
    HTTP=YES
    shift
    shift
    ;;
    --https)
    HTTPS=YES
    shift
    shift
    ;;
    --ftp)
    FTP=YES
    shift
    shift
    ;;
    --all)
    ALL=YES
    shift
    shift
    ;;
    --disable)
    DISABLE=YES
    shift
    shift
    ;;
    --help)
    HELP=YES
    shift
    ;;
    *)    
    POSITIONAL+=("$1")
    shift
    ;;
esac
done

set -- "${POSITIONAL[@]}"

if [ "${HTTP}" = "YES" ]
then
	export http_proxy="${PROXY}"
fi

if [ "${HTTPS}" = "YES" ]
then
	export https_proxy="${PROXY}"
fi

if [ "${FTP}" = "YES" ]
then
	export ftp_proxy="${PROXY}"
fi

if [ "${ALL}" = "YES" ]
then
	export http_proxy="${PROXY}"
	export https_proxy="${PROXY}"
	export ftp_proxy="${PROXY}"
fi

if [ "${DISABLE}" = "YES" ]
then
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
fi

if [ "${HELP}" = "YES" ]
then
	echo 'Usage: setprox [OPTION]... [PROXY]...'
	echo -e 'Sets up PROXY system wide.\n'
	
	echo -e '  --http,\tset up proxy for HTTP traffic'
	echo -e '  --https,\tset up proxy for HTTPS traffic'
	echo -e '  --ftp,\tset up proxy for FTP traffic'
	echo -e '  --all,\tset up proxy for ALL protocols (by default)'
	echo -e '  --disable,\tdisables all previous proxy settings'
	echo -e '  --help,\tdisplay this help and exit\n'
	
	echo -e 'Examples:\n'
	echo '  setprox --http --ftp myproxy.com'
	echo '  setprox --all myproxy.com'
	echo -e '  setprox --disable\n'	
fi
