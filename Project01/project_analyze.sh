#!/bin/bash


for input in "$@" ; do	#getting user input


	#Below is the code for the feature : TODO log

	if [ "$input" = "todolog" ] ; then
		echo "You picked the Creating TODO log Feature"

	#Checking if todo.log already exists, if so remove, if not, create one

		if [ -e todo.log ] ; then
			rm todo.log
		else
			touch todo.log
		fi

	#Exclude the #TODO line in this file
		grep -r --exclude={*.log,project_analyze.sh} '#TODO' > todo.log

		echo "TODO log has been generated"
	fi




	#Below is the code for the feature : File Type Count

	if [ "$input" = "filetypecount" ] ; then
		echo "You picked the File Type Count Feature"

		function countFunc() {
			count=$(find ./ -iname "$1" -type f | wc -l)
		echo "$count"
		}

	#Echos all the counts for all file types
		echo "File Type count:"
		echo "HTML: $(countFunc '*.html')"
		echo "Javascript: $(countFunc '*.js')"
		echo "CSS: $(countFunc '*.css')"
		echo "Python: $(countFunc '*.py')"
		echo "Haskell: $(countFunc '*.hs')"
		echo "Bash Script: $(countFunc '*.sh')"
	fi



	#Below is the code for the feature : Merge Log

	if [ "$input" = "mergelog" ] ; then
		echo "You picked the Merge Log Feature"

	#Checking if merge.log already exsits, if so, remove it, if not create one
		if [ -e merge.log ] ; then
			rm merge.log
		else
			touch merge.log
		fi

		git log --oneline | grep -i 'merge' | cut -d' ' -f1  > merge.log

		echo "Merge log has been generated"
	fi



	#Colors defined to be used in the custom feature: Colorful size log

RED='\033[0;31m'
ORANGE='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NOCOLOR='\033[0m'

COLORS=($RED $ORANGE $YELLOW $GREEN $BLUE $PURPLE)

	#Below is the code for the custom feature : Colorful size log

	if [ "$input" = "sizelog" ] ; then

		echo "You picked the Colorful Size Log feature"

	#Checking if size.log already exsits, if so, remove it, if not create one
		if [ -e size.log ] ; then
			rm size.log
		else
			touch size.log
		fi

	#gitsize = size of the whole git repo
	#filesize = size of the git repo without the hidden files (so just the files you see when you type ls

		gitsize=$(du -sh)
		filesize=$(du -h --exclude "./.*")

		echo "Total git repo size: $gitsize , Size excluding hidden files: $filesize" > size.log


	#Using the colors defined above to return the size values with colorful output
		for c in "${COLORS[@]}" ; do

		echo -e "Total git repo size: $c $gitsize $NOCOLOR Size excluding hidden files: $c $filesize $NOCOLOR"
		sleep 1

		done

		echo "Size log has been generated"

	fi
done
