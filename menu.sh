#!/bin/ksh

# Declarations
Answer=""
oldstty=$(stty -g)
current=menu
sufix=""

keyRead() {
  tput smso
  echo "Enter option."
  tput rmso
  oldstty=$(stty -g)
  stty -icanon -echo min 1 time 1
  Answer=$(dd bs=1 count=1 2>/dev/null)
  stty "${oldstty}"
  }

menuMain() {
  cat <<EOF
MAIN MENU
=========
1-MENU1
2-MENU2
3-MENU3
0-BACK
EOF
  }

menu1() {
  cat <<EOF
MENU1
=====
1-MENU11
2-MENU12
0-BACK
EOF
  }

menu11() {
  cat <<EOF
MENU11
=====
0-BACK
EOF
  }

menu12() {
  cat <<EOF
MENU12
=====
0-BACK
EOF
  }

menu2() {
  cat <<EOF
MENU2
=====
0-BACK
EOF
  }

menu3() {
  cat <<EOF
MENU3
=====
1-MENU31
2-MENU32
0-BACK
EOF
  }

menu31() {
  cat <<EOF
MENU31
=====
1-MENU311
0-BACK
EOF
  }

menu311() {
  cat <<EOF
MENU311
=====
0-BACK
EOF
  }

menu312() {
  cat <<EOF
MENU312
=====
0-BACK
EOF
  }

menuExit() {
  sufix=$(echo ${sufix}|awk '{printf("%s",substr($0,1,length-1))}')
  current="menu${sufix}"
  Answer=""
  eval ${current}
  }

menu() {
  # piece based on eval function for navigation.Quite simple but handy ..
  while true; do
    clear
    case ${Answer} in
      "") menuMain;;

       0) [ "${current}" = "menu" ] && exit 0
          menuExit;;

       *) sufix="${sufix}${Answer}"
          current="menu${sufix}"
          eval ${current} 2>/dev/null
          [ $? -ne 0 ] && menuExit;;
    esac
    keyRead
  done
  }

main() {
  menu
}

main
