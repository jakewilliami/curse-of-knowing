#! /bin/bash

#Colours
BGREEN='\033[1;38;5;2m'
ULINE='\033[1;4m'
BWHITE='\033[1;38m'
ITWHITE='\033[0;3;38m'
BYELLOW='\033[1;33m'
BRED='\033[1;31m'
BBLUE='\033[1;34m'
DARKBBLUE='\033[1;38;5;26m'
NORM='\033[0;38m'


#Filter output
LOOK_MSG='echo -e "${BYELLOW}Looking for the curse-of-knowing directory.  Please be patient.${NORM}"'
COMP_MSG='echo -e "${BYELLOW}Now compiling all figures.  This may take a moment.${NORM}"'
COMP_DONE='echo -e "${BGREEN}Compiling figures complete.${NORM}"'
CHANGE_MSG='echo -e "${BWHITE}Run the command \`${BGREEN}cd ${PATH_TO_GIT}${NORM}\`${BWHITE} to change your current directory to the Curse of Knowledge git directory.${NORM}"'
COMP_ERR='echo -e "${BRED}Not working in the Curse of Knowing directory.  See open \`-c\`.${BNORM}"'
ERR_HELP='echo -e "${BRED}Invalid option.  Use option \`-h\` for help.${NORM}"'
CONV_MSG='echo -e "${BYELLOW}Now converting all figures to JPG.  This may take a moment.${NORM}"'
CONV_DONE='echo -e "${BGREEN}Converting figures complete.  JPGs created.${NORM}"'


# Help
display_help() {
    echo -e "${BWHITE}Usage: compile.sh [option...]${NORM}"
    echo
    echo -e "${ITWHITE}The present script will compile the Curse of Knowing diagrams recursively.  Omitting options will find the git directory for you and compile the figures.${NORM}"
    echo
    echo -e "${BBLUE}\t -c | --change-directory ${BYELLOW}Explains how to change your ${ULINE}${BBLUE}c${BYELLOW}urrent directory${NORM}${BYELLOW}.${NORM}"
    echo -e "${BBLUE}\t -l | --latex-compile \t${BYELLOW}Allows you to run the ${ULINE}${BBLUE}l${BYELLOW}atex compile${NORM}${BYELLOW} command from your current directory.${NORM}"
    echo -e "${BBLUE}\t -h | --help \t\t${BYELLOW}Shows ${ULINE}${BBLUE}h${BYELLOW}elp${NORM} ${BYELLOW}(present output).${NORM}"
}


# get to curse of knowing directory
find_function() {
    find / -name ".git" -type d -print 2> >(grep -v "Permission denied" >&2) 2> >(grep -v "Operation not permitted" >&2) 2> >(grep -v "Not a directory" >&2) | \
    while IFS= read -r gitdir
    do 
        echo `dirname "$gitdir"` 
    done | grep 'curse-of-knowing'
}
fd_function() {
    fd --hidden --absolute-path --type d --color never --regex '^.git$' / | \
    while IFS= read -r gitdir
    do 
        echo `dirname "$gitdir"`
    done | grep 'curse-of-knowing'
}

#option error
opt_err() {
    eval "${ERR_HELP}"
}


# compile
latex_compile() {
    if [ "${PWD##*/}" == 'curse-of-knowing' ]
    then
        eval "${COMP_MSG}"
        for figure in $(find . -name fig.tex -type f -print); do
          cd `dirname ${figure}` && texfot pdflatex fig.tex
          cd -
        done
        eval "${CONV_MSG}"
        for figure in $(find . -name fig.pdf -type f -print); do 
            cd `dirname ${figure}` && convert -density 1000 fig.pdf fig.png
            cd -
        done
        eval "${CONV_DONE}"
        if which open > /dev/null 2>&1
        then
            open .
        elif which xdg-open > /dev/null 2>&1
        then
            xdg-open .
        fi
    else
        eval "${COMP_ERR}" 
    fi
}

#determine which find function to use
look_for_git_and_compile() {
    eval "${LOOK_MSG}"
    if which fd > /dev/null 2>&1
    then
        PATH_TO_GIT="$(fd_function)"
        cd "${PATH_TO_GIT}"
        if which open > /dev/null 2>&1
        then
            latex_compile
            open .
        elif which xdg-open > /dev/null 2>&1
        then
            latex_compile
            xdg-open .
        fi
    else
        PATH_TO_GIT="$(fd_function)"
        cd "${PATH_TO_GIT}"
        if which open > /dev/null 2>&1
        then
            latex_compile 
            open .
        elif which xdg-open > /dev/null 2>&1
        then
            latex_compile
            xdg-open .
        fi
    fi
}


#Go to curse of knowledge directory
go_to_dir() {
    if which fd > /dev/null 2>&1
    then
        PATH_TO_GIT="$(fd_function | sed 's/ /\\ /g')"
        eval "${CHANGE_MSG}"
    else
        PATH_TO_GIT="$(find_function | sed 's/ /\\ /g')"
        eval "${CHANGE_MSG}" 
    fi
}


# Options
while getopts ":-:hcl" OPTION; do
        case $OPTION in
                -)
                    case $OPTARG in
                        change-directory)
                            go_to_dir ;;
                        latex-compile)       
                            latex_compile ;;
                        help)
                            display_help ;;
                        *)
                            opt_err ;;
                    esac ;;
                c)
                    go_to_dir ;;
                l)
                    latex_compile ;;
                h)
                    display_help ;;
                *)
                    opt_err ;;
        esac
done


# If no options
[[ -z $1 ]] && look_for_git_and_compile