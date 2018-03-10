#!/usr/bin/env bash
#
# v2.0.0    2018-03-10    webdev@highskillz.com
#
set -e
set -o pipefail
set -x

# common PHP packages, focused on Moodle
# https://docs.moodle.org/34/en/PHP
# https://docs.moodle.org/31/en/PHP
# https://docs.moodle.org/31/en/Compiling_PHP_from_source
# https://docs.moodle.org/34/en/Compiling_PHP_from_source


# check we are on Ubuntu 16.04 / xenial
[ "$(source /etc/os-release && echo $VERSION_ID)" == "16.04" ] || exit -21

# need PHP version defined
[ -z "$1" ] && exit -24

# check the installed PHP version is as expected
if ! php -v | grep --quiet -m 1 "$1"; then
    exit -27
fi
TARGET_PHP_VERSION=$1
shift

# we are not building from source, so there should be no need to install the
# underlying libs themselves

INSTALL_PHP=""
INSTALL_APT=""

FORCE_MCRYPT="${FORCE_MCRYPT:-0}"
FORCE_OLD_ZLIB="${FORCE_OLD_ZLIB:-0}"

# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
for iarg in "$@"
do
    case $iarg in
        "mcrypt")
            FORCE_MCRYPT=1
            ;;
        "oldzlib")
            FORCE_OLD_ZLIB=1
            ;;
        "mysql" | "mysqli")
            INSTALL_PHP="${INSTALL_PHP} pdo mysqli pdo-mysql"
            ;;
        "postgres" | "pgsql")
            INSTALL_PHP="${INSTALL_PHP} pdo pgsql pdo-pgsql"
            ;;
        "mongo" | "mongodb")
            INSTALL_PHP="${INSTALL_PHP} mongodb"
            ;;
        "odbc")
            INSTALL_PHP="${INSTALL_PHP} odbc"
            ;;
        *)
            ;;
    esac
    shift
done

# Most of these are mentioned as required by moodle 3.1+
INSTALL_PHP="${INSTALL_PHP} iconv"
INSTALL_PHP="${INSTALL_PHP} mbstring"
INSTALL_PHP="${INSTALL_PHP} curl"
INSTALL_PHP="${INSTALL_PHP} tokenizer"
INSTALL_PHP="${INSTALL_PHP} xmlrpc"
INSTALL_PHP="${INSTALL_PHP} soap"
INSTALL_PHP="${INSTALL_PHP} ctype"
INSTALL_PHP="${INSTALL_PHP} gd"
INSTALL_PHP="${INSTALL_PHP} simplexml"
INSTALL_PHP="${INSTALL_PHP} dom"
INSTALL_PHP="${INSTALL_PHP} xml"
INSTALL_PHP="${INSTALL_PHP} intl"
INSTALL_PHP="${INSTALL_PHP} json"

# if [ "${FORCE_OLD_ZLIB}" != "1" ]; then
# #   WARNING: Use of bundled libzip is deprecated and will be removed.
# #   WARNING: Some features such as encryption and bzip2 are not available.
# #   WARNING: Use system library and --with-libzip is recommended.
    INSTALL_PHP="${INSTALL_PHP} zip"
# fi

# Most of these are mentioned as required by moodle 3.1+
INSTALL_PHP="${INSTALL_PHP} xmlreader"
INSTALL_PHP="${INSTALL_PHP} xmlwriter"
INSTALL_PHP="${INSTALL_PHP} xsl"
INSTALL_PHP="${INSTALL_PHP} phar"
INSTALL_PHP="${INSTALL_PHP} posix"
INSTALL_PHP="${INSTALL_PHP} sockets"
INSTALL_PHP="${INSTALL_PHP} tidy"
INSTALL_PHP="${INSTALL_PHP} yaml"
INSTALL_PHP="${INSTALL_PHP} bcmath"
INSTALL_PHP="${INSTALL_PHP} dom"
INSTALL_PHP="${INSTALL_PHP} fileinfo"
INSTALL_PHP="${INSTALL_PHP} pdo pdo-sqlite"

# discontinued on PHP7.2+ and prob not needed on 3.2+, so we only install it if we really have to
# if [ "${FORCE_MCRYPT}" == "1" ]; then
    if [ "${TARGET_PHP_VERSION}" == "7.0" ] || [ "${TARGET_PHP_VERSION}" == "7.1" ]; then
        INSTALL_PHP="${INSTALL_PHP} mcrypt"
    fi
# fi
# other that may be usefull
INSTALL_PHP="${INSTALL_PHP} bz2"
INSTALL_PHP="${INSTALL_PHP} ldap"
INSTALL_PHP="${INSTALL_PHP} imap"
INSTALL_PHP="${INSTALL_PHP} pspell"
INSTALL_PHP="${INSTALL_PHP} tideways"
INSTALL_PHP="${INSTALL_PHP} recode"
INSTALL_PHP="${INSTALL_PHP} gmp"

# xdebug


# ==============================================================================
echo "##################################################"
echo "INSTALL_APT:::: ${INSTALL_APT}"
echo "INSTALL_PHP:::: ${INSTALL_PHP}"

# ==============================================================================
# Since we are installing from odrej/php, we prob don't have to worry about installing from source
# so we will convert php modules to php-prefixed apt packages
for phppkg in $INSTALL_PHP
do
    INSTALL_APT="${INSTALL_APT} php${TARGET_PHP_VERSION}-${phppkg}"
done
unset INSTALL_PHP

# we should also not need to confgure explicitly

# apt-get update only if we have to...
[ "$(ls /var/lib/apt/lists)" ] || apt-get update

[ -n "${INSTALL_APT}"  ] && apt-get install -y ${INSTALL_APT}

[ -n "${INSTALL_PHP}"  ] && docker-php-ext-install -j$(nproc) ${INSTALL_PHP}

apt-get clean all
apt-get purge