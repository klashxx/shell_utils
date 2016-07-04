#!/usr/bin/env bash
set -e

readonly SCRIPT=$(basename $0)
readonly LOG=./${SCRIPT%.*}.bash.log

source ./logger.sh

function setup_file_logger {
  >$LOG
  fileConfig["filename"]=$LOG
  fileConfig["level"]='DEBUG'
  fileConfig["format"]='[%s] %-8s - %-5s - %s\n'
  fileConfig["datefmt"]='%Y-%m-%dT%H:%M:%S,%3N'
  loggers+=('file')

}


function setup_stream_logger {
  streamConfig["level"]='INFO'
  streamConfig["format"]='%-8s:  %s\n'
  loggers+=('stream')
}

function main {

  setup_file_logger
  setup_stream_logger

  log INFO $LINENO "INFO line"
  log DEBUG $LINENO "DEBUG line. Only to logfile"
  log WARNING $LINENO "WARNING line"
  log ERROR $LINENO "ERROR line"
  log CRITICAL $LINENO "CRITICAL line"

}

main "$@" 
