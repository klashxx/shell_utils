declare -a loggers
declare -A fileConfig
declare -A streamConfig
declare -A LEVELS=(["DEBUG"]=10 ["INFO"]=20 ["WARNING"]=30
                   ["ERROR"]=40 ["CRITICAL"]=50)
readonly LEVELS


function log {
  declare -a comp
  local level=$1
  local line=$2
  shift 2

  for logger in "${loggers[@]}"; do
    cnflevel="$(eval echo \${${logger}Config[level]})"
    (( ${LEVELS[${level}]} < ${LEVELS[${cnflevel}]} )) && continue

    datefmt="$(eval echo \${${logger}Config["datefmt"]})"

    [ $datefmt ] && { local time_stamp=$(date +"${datefmt}"); comp+=("${time_stamp}"); }

    format="$(eval echo \${${logger}Config["format"]})"

    comp+=("${level}")


    if [ $logger = file ]; then
      comp+=("${line}")
      exec 6>&1
      exec >>${fileConfig[filename]}
    fi

    printf "${format}" ${comp[@]} "$@"

    if [ $logger = file ]; then
      exec 1>&6 6>&-
    fi

    unset comp format datefmt time_stamp
  done
}

