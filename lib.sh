function log {
  typeset time_stamp=$(date +'%Y-%m-%dT%H:%M:%S')
  echo  "[${time_stamp}] $@"
}


function salida_error {
  typeset msj=${1:-""}
  typeset code=${2:-5}

  log "critical: ${msj}"
  exit ${code}
} >&2


function salida_ok {
  exit 0
}


function valida {
  typeset exit_code=$1

  if [ $exit_code -ne 0 ]; then
    salida_error "runtime error"
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
  typeset size=${1:-0}

  find . -size +${size}c \
         -type f \
         -exec \
            ls -C -A -l \
            --time-style="+%Y-%m-%d %H:%M:%S" {} \; 2>/dev/null| \
         sort -r -k 5n | \
         awk 'BEGIN{
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
} 
