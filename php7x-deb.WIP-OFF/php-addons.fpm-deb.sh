#!/usr/bin/env bash
#
# v1.0.0    2018-03-04    webdev@highskillz.com
#
set -e
set -o pipefail
set -x

# https://docs.moodle.org/34/en/PHP
# https://docs.moodle.org/31/en/PHP
# https://docs.moodle.org/31/en/Compiling_PHP_from_source
# https://docs.moodle.org/34/en/Compiling_PHP_from_source


FORCE_MCRYPT="${FORCE_MCRYPT:-0}"
[ "$1" == "mcrypt" ] && shift && FORCE_MCRYPT=1

FORCE_OLD_ZLIB="${FORCE_OLD_ZLIB:-0}"
[ "$1" == "oldzlib" ] && shift && FORCE_OLD_ZLIB=1

[ "$1" == "mysql"    ] && shift && ADD__MYSQL=1
[ "$1" == "mysqli"   ] && shift && ADD__MYSQL=1
[ "$1" == "postgres" ] && shift && ADD__POSTGRES=1
[ "$1" == "pgsql"    ] && shift && ADD__POSTGRES=1
[ "$1" == "mongo"    ] && shift && ADD__MONGO=1
[ "$1" == "mongodb"  ] && shift && ADD__MONGO=1

CONFIG_PHP=()
INSTALL_PHP=""
INSTALL_PECL=""
INSTALL_APT=""


# =================================================================================
# required 3.1+
#
# seems to be in 7.2
# INSTALL_PHP="${INSTALL_PHP} iconv"

# seems to be in 7.2
# INSTALL_PHP="${INSTALL_PHP} mbstring"

# seems to be in 7.2
# INSTALL_PHP="${INSTALL_PHP} curl"
# INSTALL_APT="${INSTALL_APT} curl-dev"

# apparently not needed in 7.2
# INSTALL_PHP="${INSTALL_PHP} openssl"
# INSTALL_APT="${INSTALL_APT}"

# apparently not needed in 7.2
# INSTALL_PHP="${INSTALL_PHP} tokenizer"

INSTALL_PHP="${INSTALL_PHP} xmlrpc"
INSTALL_PHP="${INSTALL_PHP} soap"
INSTALL_APT="${INSTALL_APT} libxml2-dev"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} ctype"

if [ "${FORCE_OLD_ZLIB}" == "1" ]; then
    #   WARNING: Use of bundled libzip is deprecated and will be removed.
    #   WARNING: Some features such as encryption and bzip2 are not available.
    #   WARNING: Use system library and --with-libzip is recommended.
    INSTALL_APT="${INSTALL_APT}"
else
    INSTALL_PHP="${INSTALL_PHP} zip"
    #INSTALL_APT="${INSTALL_APT} zlib-dev"
fi

# gd
INSTALL_PHP="${INSTALL_PHP} gd"
INSTALL_APT="${INSTALL_APT} libpng-dev libjpeg-turbo-dev libwebp-dev libxpm-dev freetype-dev"

#docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
CONFIG_PHP+=("gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/")

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} simplexml"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} spl"

# seems to exist in 7.2
# INSTALL_APT="${INSTALL_APT} pcre"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} dom"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} xml"

INSTALL_PHP="${INSTALL_PHP} intl"
INSTALL_APT="${INSTALL_APT} icu-dev"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} json"

# =================================================================================
# required 3.1+
#
# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} xmlreader"

# =================================================================================
# Other
#
# discontinued on PHP7.2+ and prob not needed on 3.2+, so we only install it if we really have to
if [ "${FORCE_MCRYPT}" == "1" ]; then
    INSTALL_PHP="${INSTALL_PHP} mcrypt"
    INSTALL_APT="${INSTALL_APT} libmcrypt-dev"
fi

#INSTALL_PHP="${INSTALL_PHP} xmlreader xmlwriter xsl"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} xmlwriter"

INSTALL_PHP="${INSTALL_PHP} xsl"
INSTALL_APT="${INSTALL_APT} libxslt-dev"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} phar"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} posix"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} sockets"

INSTALL_PHP="${INSTALL_PHP} tidy"
INSTALL_APT="${INSTALL_APT} tidyhtml-dev"

# Can't find how to insall on 7.2 on alpine
# INSTALL_PHP="${INSTALL_PHP} yaml"
# INSTALL_APT="${INSTALL_APT} yaml-dev"

INSTALL_PHP="${INSTALL_PHP} bcmath"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} dom"
# INSTALL_APT="${INSTALL_APT}"

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} fileinfo"
# INSTALL_APT="${INSTALL_APT}"

# =================================================================================
# DB
#
if [ "${ADD__MYSQL}" == "1" ]; then
    INSTALL_APT="${INSTALL_APT}"
    INSTALL_PHP="${INSTALL_PHP} pdo mysqli"
    #INSTALL_PHP="${INSTALL_PHP} pdo mysqli pdo-mysql"
fi
if [ "${ADD__POSTGRES}" == "1" ]; then
    INSTALL_APT="${INSTALL_APT} postgresql-dev"
    INSTALL_PHP="${INSTALL_PHP} pdo pgsql pdo-pgsql"
    shift
fi
if [ "${ADD__MONGO}" == "1" ]; then
    INSTALL_PECL="${INSTALL_PECL} mongodb"
fi

# seems to exist in 7.2
# INSTALL_PHP="${INSTALL_PHP} pdo-sqlite"

# ==============================================================================
echo "##################################################"
echo "INSTALL_APT:::: ${INSTALL_APT}"
echo "CONFIG_PHP::::: ${CONFIG_PHP}"
echo "INSTALL_PHP:::: ${INSTALL_PHP}"
echo "INSTALL_PECL::: ${INSTALL_PECL}"

apt-get update

[ -n "${INSTALL_APT}"  ] && apt-get install -y ${INSTALL_APT}

for cfg in ${!CONFIG_PHP[*]}
do
    docker-php-ext-configure ${CONFIG_PHP[$cfg]}
done

[ -n "${INSTALL_PHP}"  ] && docker-php-ext-install -j$(nproc) ${INSTALL_PHP}
[ -n "${INSTALL_PECL}" ] && pecl install ${INSTALL_PECL}

apt-get clean all
apt-get purge