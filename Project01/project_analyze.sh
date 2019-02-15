#!/bin/bash


for input in "$@" ; do 

	if [ "$input" = "TODOlog" ] ; then
		echo "You picked the Creating TODO log Feature" 
		if [ -e todo.log ] ; then
			rm todo.log
		else
			touch todo.log
		fi
		grep -r --exclude={*.log,project_analyze.sh} '#TODO' > todo.log

		echo "TODO log has been generated"
	fi

done
