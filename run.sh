#!/bin/bash

# DESCRIPTION
# Executes the command line interface.

# USAGE
# ./run.sh OPTION

# SETTINGS
set -o nounset # Exit, with error message, when attempting to use an undefined variable.
set -o errexit # Abort script at first error, when a command exits with non-zero status.
set -o pipefail # Returns exit status of the last command in the pipe that returned a non-zero return value.
IFS=$'\n\t' # Defines how Bash splits words and iterates arrays. This defines newlines and tabs as delimiters.

export ARCHIVER_HOME="$HOME/.archiver"
export ARCHIVER_SETTINGS="$ARCHIVER_HOME/settings.sh"
export ARCHIVER_MANIFEST="$ARCHIVER_HOME/manifest.txt"
if [ -e "$ARCHIVER_SETTINGS" ]; then
  source "$ARCHIVER_SETTINGS"
fi
export BACKUP_SERVER_CONNECTION="$BACKUP_USER@$BACKUP_SERVER"
export BACKUP_PATH="$BACKUP_ROOT/$BACKUP_NAME"
export BACKUP_LOG="/tmp/$BACKUP_MACHINE-$BACKUP_NAME-backup.txt"

# LIBRARY
source lib/utilities.sh
source lib/options.sh

# EXECUTION
while true; do
  if [[ $# == 0 ]]; then
    printf "\nUsage: run OPTION\n"
    printf "\nArchiver Options:\n"
    printf "  s: Setup current machine.\n"
    printf "  b: Backup to remote server.\n"
    printf "  c: Clean backups (enforces backup limit).\n"
    printf "  q: Quit/Exit.\n\n"
    read -p "Enter selection: " response
    printf "\n"
    process_option $response
  else
    process_option $1
  fi
done
