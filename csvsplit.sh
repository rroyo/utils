#!/bin/bash
# (Couldn't resist adding the ASCII!)

                                ##############
                        ##############################
                ##############################################
        ###############################################################
###############################################################################
###################   Cursed Monkey Proudly Presents You   ####################
#######################   Large CSV Splitter v6.6.6.   ########################
###############################################################################
##                                                                           ##
##  Split a Large CSV into multiple smaller CSV files                        ##
##                                                                           ##
##  As an example of use: in my experience, Google Sheets won't convert CSV  ##
##  files too its native format, if these files exceed roughly 250.000 rows. ##
##  So you'll have to split them.                                            ##
##                                                                           ##
##  Usage:                                                                   ##
##                                                                           ##
##      csvsplit.sh <CSV file> [MAXROWS]                                     ##
##                                                                           ##
##      If no MAXROWS are specified it'll default to 250.000                 ##
##                                                                           ##
##  Output:                                                                  ##
##                                                                           ##
##      ../output/<split CSV files numbered up to 666>                       ##
##                                                                           ##
##      I dare you to go over 666 files...                                   ##
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
BASENAME=$(basename -s .csv "$1")        # remove .csv extension
MAXROWS=250000
COUNTER=1
HEADER='_____header.csv'
CONTENT='_____content.csv'

if (( $2 )); then
  MAXROWS=$2
fi

# create output dir and temporary dir
mkdir $OUTPUT
mkdir $OUTPUT/_tmp

#############
### SPLIT ###
#############

# create a temporary file containing the header without the content
head -n 1 $1 > $HEADER
 
# create a temporary file containing the content without the header
tail +2 $1 > $CONTENT
 
# split the content file into multiple files
split --suffix-length=3 --numeric-suffixes=1 --additional-suffix=.csv -l $MAXROWS $CONTENT $OUTPUT/_tmp/$BASENAME

####################################
### JOIN HEADER WITH SPLIT FILES ###
####################################
for file in `ls -p $OUTPUT/_tmp | grep -v /`
do
    cat $HEADER $OUTPUT/_tmp/$file > $OUTPUT/$file
    
    if (( $COUNTER == 666 ))
    then
        echo
        echo
        echo "Invoking Its Majesty Satan..."
        echo
        echo
        echo "
                       .                                                      .          
                     .n                   .                 .                  n.        
               .   .dP                  dP                   9b                 9b.    . 
              4    qXb         .       dX                     Xb       .        dXp     t
             dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
             9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
              9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
                9XXXXXXXXXXXXXXXXXXXXX ~   ~ OOO8b   d8OOO ~   ~ XXXXXXXXXXXXXXXXXXXXXP  
                  9XXXXXXXXXXXP   9XX    DIE     98v8P   HUMAN    XXP   9XXXXXXXXXXXP    
                     ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~       
                                     )b.  .dbo.dP  v  9b.odb.  .dX(                      
                                   ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.                     
                                  dXXXXXXXXXXXP    .    9XXXXXXXXXXXb                    
                                 dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb                   
                                 9XXb     XXXXXb.dX|Xb.dXXXXX     dXXP                   
                                          9XXXXXX(   )XXXXXXP                            
                                           XXXX X. v .X XXXX                             
                                           XP^X  b   d  X^XX                             
                                           X. 9         P )X                             
                                            b             d                              

                                                                                         
        "
        xdg-open "https://www.youtube.com/watch?v=mUv8GxrqXPk"
        break
    fi
    
    COUNTER=$((COUNTER+1))
done

# remove temporary files
rm $HEADER $CONTENT $OUTPUT/_tmp/*
rmdir $OUTPUT/_tmp
