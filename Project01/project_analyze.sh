#!/bin/bash


for input in "$@" ; do	#getting user input  


	#Below is the code for the feature : TODO log

	if [ "$input" = "todolog" ] ; then
		echo "You picked the Creating TODO log Feature"
		if [ -e todo.log ] ; then
			rm todo.log
		else
			touch todo.log
		fi
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

		echo "File Type count:"
		echo "HTML: $(countFunc '*.html')"
		echo "Javascript: $(countFunc '*.js')"
		echo "CSS: $(countFunc '*.css')"
		echo "Python: $(countFunc '*.py')"
		echo "Haskell: $(countFunc '*.hs')"
		echo "Bash Script: $(countFunc '*.sh')"
	fi

done
