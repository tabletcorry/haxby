# color-echo.sh: Echoing text messages in color.
# Borrowed from: http://tldp.org/LDP/abs/html/colorizing.html#COLORECHO
# Modify this script for your own purposes.
# It's easier than hand-coding color.

blue='\e[1;34m'
green='\e[1;32m'
red='\e[1;31m'
bg_red='\e[1;41m'

cecho ()                     # Color-echo.
                             # Argument $1 = message
                             # Argument $2 = color
{
local default_msg="No message passed."
                             # Doesn't really need to be a local variable.

message=${1:-$default_msg}   # Defaults to default message.
color=${2:-$black}           # Defaults to black, if not specified.

  echo -en "$color"
  echo $3 "$message"
  tput sgr0                      # Reset to normal.

  return
} 
