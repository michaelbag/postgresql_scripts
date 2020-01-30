#!/bin/bash

# Bash scripte for custom format backup of postgresql database.
#
# Author: Mikhail Kudryavtsev
#
# * Don't forget in user home folder should be .pgpass file
#  in format like:
#
#<hostname>:<port>:<database>:<username>:<password>
#
# Read https://wiki.postgresql.org/wiki/Pgpass for more information.

if [ $# -ne 3 ]; then
  echo "usage: dumb_db <username> <db_name> <dump_file>"
  exit 1
fi

USERNAME="$1"

sudo -u $USERNAME pg_dump -Fc -U $USERNAME $2 | pv -s $(sudo -u $USERNAME psql -tc "select pg_database_size('$2')") > $3
