# color-echo.sh: Echoing text messages in color.
# Borrowed from: http://tldp.org/LDP/abs/html/colorizing.html#COLORECHO

FG_BLUE='\033[1;34m'
FG_GREEN='\033[1;32m'
FG_RED='\033[1;31m'
BG_RED='\033[1;41m'

# Color-echo.
# Argument $1 = message
# Argument $2 = color
# Argument $3 = echo options (optional)
function cecho
{
    if [ -z "$TERM" -o "$TERM" == "dumb" ]; then
        echo $3 "$message"
    else
        message=$1
        color=${2:-$black}           # Defaults to black, if not specified.

        echo -en "$color"
        echo $3 "$message"
        tput sgr0                      # Reset to normal.
    fi
} 
