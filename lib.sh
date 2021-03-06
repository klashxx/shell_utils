#!/usr/bin/env bash

function separator {
  local long=${1:-100}

  gawk -v long=$long 'BEGIN{while (++i<=long+0)printf "-";print ""}'
}


function supported {
  local os=$(uname -s)

  [ $os != Linux ] && error "$os NOT supported."
  [ -z $BASH ] && error "Not soported SHELL"
}


function log {
  local time_stamp=$(date +'%Y-%m-%dT%H:%M:%S')
  echo  "[${time_stamp}] $@"
}


function error {
  local msj=${1:-""}
  local code=${2:-5}

  log "critical: ${msj}"
  return $code
} >&2


function check {
  local exit_code=$1

  if [ $exit_code -ne 0 ]; then
    error "runtime error"
  fi
}


function rgrep {
  local pattern="${1:-""}"
  local path="${2:-"."}"
  local include="${3:-""}"

  grep  -r "${pattern}"  --color --include=*${include} $path 2>/dev/null
}


function tophist {
  history | \
  gawk 'BEGIN{
          if (PROCINFO["version"] < "4.0.0") {
            print "Requires gawk >= 4"
            exit
          }
          PROCINFO["sorted_in"] = "@val_num_desc"
        }
        !/.\//{
          CMD[$2]++
          count++
        }
        END{
          for (a in CMD){
            c++
            printf("%02d   %02d   %04.1f%s   %s\n",c,CMD[a],CMD[a]/count*100, "%", a)
            if (c==10){
              exit
            }
          }
        }'
}


function since {
  local date="${1}"

  echo $(($(date +"%s")-$(date -d "${date}" +"%s")))| \
      gawk '{printf "%d days %02d hours %02d mins %02d seconds\n" ,
            $0/86400,
            $0%86400/3600,
            $0%86400%3600/60,
            $0%60}'
} 2>/dev/null


function bigger_than {
  local cmd=${1:-0}

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


function older {
   than "+" ${@:2}
}


function newer {
   than "-" ${@:2}
}


function than {
  local part=$1
  local ref="${@:2}"
  local value=${ref% *}
  local mode=${ref#* }

  if [ $part = "+" ];then
    pred="!"
  else
    pred=""
  fi

  case "${mode}" in
    mins ) cmd="-mmin $part$value";;
    days ) cmd="-mtime $part$value";;
        *) cmd="$pred -newer \"${ref}\" ! -name \"${ref}\""
  esac

  eval find . \
       -type f \
       $cmd \
       -exec \
          ls -C -A -l \
          --time-style=\"+%Y-%m-%d %H:%M:%S\" {} \\\;
} 2>/dev/null


function tree  {
  local hook="${1:-.}"

  find $hook -type d -print 2>/dev/null |\
  gawk  -F\/ '{for (i=1;i<NF;i++)
                printf("%"length($i)"s","|")
              gsub(/[^\/]*\//,"--",$0)
              print $NF}'
} 2>/dev/null


function vdf {
  local hook="${1:-}"

  df ${hook} \
     --block-size=1K \
     --local \
     --print-type \
     --portability \
     --exclude-type=tmpfs 2>/dev/null| \
     sort -k5nr 2>/dev/null | \
     gawk 'BEGIN{
             MASK="%-20s => [%14s] [%3s] (%s)\n"}

           NR==1{
             printf(MASK,"Mount","Available","Use","Type")
             while (i++ < 53) printf "="
             print ""}

           /%/{
             available=$5
             if (available > 1024*1024)
               available=sprintf("%.2f GBs", available/1024/1024)
             else if (available > 1024)
               available=sprintf("%d MBs", available/1024)
             else
               available=sprintf("%d KBs", available)
             printf(MASK, $NF,available,$(NF-1),$2)}'
} 2>/dev/null
