#!/bin/bash
# (Couldn't resist adding the ASCII!)

                                ##############
                        ##############################
                ##############################################
        ###############################################################
###############################################################################
###############################################################################
##                                                                           ##
##         .                                                      .          ##
##       .n                   .                 .                  n.        ##
## .   .dP                  dP                   9b                 9b.    . ##
##4    qXb         .       dX                     Xb       .        dXp     t##
#dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb#
#9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP#
##9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP##
## `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP' ##
##   `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'   ##
##       ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~       ##
##                       )b.  .dbo.dP'`v'`9b.odb.  .dX(                      ##
##                     ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.                     ##
##                    dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb                    ##
##                   dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb                   ##
##                   9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP                   ##
##                    `'      9XXXXXX(   )XXXXXXP      `'                    ##
##                             XXXX X.`v'.X XXXX                             ##
##                             XP^X'`b   d'`X^XX                             ##
##                             X. 9  `   '  P )X                             ##
##                             `b  `       '  d'                             ##
##                               `             '                             ##
##                                                                           ##
###############################################################################
###################   Cursed Monkey Proudly Presents You   ####################
##############   CSV Splitter for Google Drive Max Size v6.6.6.   #############
###############################################################################
##                                                                           ##
##  Split a Large CSV to Google Drive Max File Size (95MB to be safe)        ##
##                                                                           ##
##  Google Sheets won't convert to its native format CSV files larger        ##
##  than 100MB (more or less). You'll have to split them.                    ##
##                                                                           ##
##  Usage:                                                                   ##
##                                                                           ##
##      csvsplit.sh <CSV file>                                               ##
##                                                                           ##
##  Output:                                                                  ##
##                                                                           ##
##      ../output/<split CSV files numbered up to 666>                       ##
##                                                                           ##
##  Must have:                                                               ##
##                                                                           ##
##      ◦ split, tail, head, cat commands                                    ##
##      ◦ sacrificial knife, live goat (optional)                            ##
##                                                                           ##
##                                                                2021/12/06 ##
##                                                                           ##
###############################################################################
###############################################################################
##                                                                           ##
##           ▄████▄   ██▀███  ▓█████ ▓█████▄  ██▓▄▄▄█████▓  ██████           ##
##          ▒██▀ ▀█  ▓██ ▒ ██▒▓█   ▀ ▒██▀ ██▌▓██▒▓  ██▒ ▓▒▒██    ▒           ##
##          ▒▓█    ▄ ▓██ ░▄█ ▒▒███   ░██   █▌▒██▒▒ ▓██░ ▒░░ ▓██▄             ##
##          ▒▓▓▄ ▄██▒▒██▀▀█▄  ▒▓█  ▄ ░▓█▄   ▌░██░░ ▓██▓ ░   ▒   ██▒          ##
##          ▒ ▓███▀ ░░██▓ ▒██▒░▒████▒░▒████▓ ░██░  ▒██▒ ░ ▒██████▒▒          ##
##          ░ ░▒ ▒  ░░ ▒▓ ░▒▓░░░ ▒░ ░ ▒▒▓  ▒ ░▓    ▒ ░░   ▒ ▒▓▒ ▒ ░          ##
##            ░  ▒     ░▒ ░ ▒░ ░ ░  ░ ░ ▒ was ▒ ░    ░    ░ ░▒  ░ ░          ##
##          ░ This     ░░   ░    ░    ░ ░  ░  ▒ ░  ░      ░  ░  ░            ##
##          ░ ░         ░ script ░  ░   ░  ░   assembled     ░               ##
##          ░                         ░                   thanks to          ##
##                                                                           ##
###############################################################################
##                                                                           ##
##    Chris J. Lee GitHub:                                                   ##
##        https://gist.github.com/chrisjlee/4321221                          ##
##                                                                           ##
##    pbm's Unix.Stackexchange answer:                                       ##
##        https://unix.stackexchange.com/a/40528/427941                      ##
##                                                                           ##
##    Patrick Gillespie, Software used for the ASCII text:                   ##
##        https://patorjk.com/software/taag/                                 ##
##                                                                           ##
##    ASCII Skull:                                                           ##
##        http://www.asciiworld.com/-Death-Co-.html                          ##
##                                                                           ##
###############################################################################
###############################################################################
        ###############################################################
                ##############################################
                        ##############################
                                ##############


# check if input filename was given
if (( ! $# == 1 )); then
  echo "Please specify the name of a CSV to split!"
  exit
fi

##############
# INITIALIZE #
##############

OUTPUT="output"
BASENAME=$(basename -s .csv "$1")        # remove extension
COUNTER=1
HEADER='_____header.csv'
CONTENT=''_____content.csv''

# create output dir and temporary dir
mkdir $OUTPUT
mkdir $OUTPUT/_tmp

#############
### SPLIT ###
#############

# create a temporary file containing the header without the content:
head -n 1 $1 > $HEADER
 
# create a temporary file containing the content without the header:
tail +2 $1 > $CONTENT
 
# split the content file into multiple 95MB files and remove _____content.csv:
split --suffix-length=3 --numeric-suffixes=1 --additional-suffix=.csv -b 99614720 $CONTENT $OUTPUT/_tmp/$BASENAME

#####################
### JOIN & RENAME ###
#####################
for file in `ls -p $OUTPUT/_tmp | grep -v /`
do
    filename=$BASENAME
    
    if (( $COUNTER > 666 ))
    then
        echo "Invoking Its Majesty Satan..."
        xdg-open "https://www.youtube.com/watch?v=mUv8GxrqXPk"
        exit
    elif (( $COUNTER > 99 ))
    then
        FILLER=""
    elif (( $COUNTER > 9 ))
    then
        FILLER="0"
    else
        FILLER="00"
    fi

    cat $HEADER $OUTPUT/_tmp/$file > $OUTPUT/$file

    #mv "$OUTPUT/$file" "$OUTPUT/$filename$FILLER$COUNTER".'csv'
    COUNTER=$((COUNTER+1))
done

# remove temporary files
rm $HEADER $CONTENT $OUTPUT/_tmp/*
rmdir $OUTPUT/_tmp
