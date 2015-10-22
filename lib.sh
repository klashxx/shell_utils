
function not_supported {
  [ $(uname -s) != Linux ] && error "Not soported OS"
  [ -z $BASH ] && error "Not soported SHELL"
  return 5
}


function log {
  typeset time_stamp=$(date +'%Y-%m-%dT%H:%M:%S')
  echo  "[${time_stamp}] $@"
}


function error {
  typeset msj=${1:-""}
  typeset code=${2:-5}

  log "critical: ${msj}"
  return $code
} >&2


function ok_exit {
  exit 0
}


function check {
  typeset exit_code=$1

  if [ $exit_code -ne 0 ]; then
    error "runtime error"
  fi
}


function since {
  typeset date="${1}"

  echo $(($(date +"%s")-$(date -d "${date}" +"%s")))| \
      gawk '{printf "%d days %02d hours %02d mins %02d seconds\n" ,
            $0/86400,
            $0%86400/3600,
            $0%86400%3600/60,
            $0%60}'
} 2>/dev/null


function bigger_than {
  typeset cmd=${1:-0}

  size=${cmd//[a-zA-Z]/}
  block=${cmd//[0-9]/}

  [ -z $block ] && block=c

  find . -size +${size}${block} \
         -type f \
         -exec \
            ls -C -A -l \
            --time-style="+%Y-%m-%d %H:%M:%S" {} \; 2>/dev/null| \
         sort -r -k 5n  2>/dev/null| \
         gawk 'BEGIN{
                 MASK="%10s => [%-90s] (%s)\n"}

               NR==1{
                 printf(MASK,"Size","File","Timestamp")
                 while (i++ < 120) printf "="
                 print ""}

               {                
                size=$5
                if (size > 1024*1024*1024)
                  size=sprintf("%.2f GBs", size/1024/1024/1024)
                else if (size > 1024*1024)
                  size=sprintf("%.1f MBs", size/1024/1024)
                else if (size > 1024)
                  size=sprintf("%d KBs", size/1024)

                printf(MASK, size, $NF, $6, $7)}'
} 2>/dev/null
