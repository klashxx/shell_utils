# a oneliner pseudo `tree` emulator
find . -type d -print 2>/dev/null |\
  awk  -F\/ '{for (i=1;i<NF;i++)
                printf("%"length($i)"s","|")
              gsub(/[^\/]*\//,"--",$0)
              print $NF}'

