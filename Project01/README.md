# *Project 1 - Lonnie Kim*


## Basics:

Project 1 is an interactive script that allows users to run various features


## Input:

Every feature listed below can be executed by typing in the command (no space, no caps) after: ./project_analyze.sh 
The commands are listed below


## Features/Commands:

### 1. **TODO log**

- Creates a file todo.log that collects all the lines with the tag #TODO
- The lines can be viewd by typing in the command: **cat todo.log**
- Command to execute this feature is **./project_analyze.sh todolog** 

### 2. **File Type Count**

- Counts how many HTMl, Javascript, CSS, Python, Haskell and Bash Script files are in the repo
- Command to execute this feature is **./project_analyze.sh filetypecount**

### 3. **Merge log** 

- Creates a file **merge.log** that finds and collects all the commit commit hashes where the word "merge" is mentioned
- Command to execute this feature is **./project_analyze.sh mergelog**

### 4. **Custom Feature: Colorful Size Log**
- Creates a file **size.log** that finds the size of the whole git repo, and size of the repo excluding the hidden files (basically only the files you see when you type in ls into the command line)
- It outputs the size value with the colors of the rainbow as they change every second
- The size value can also be viewd again by typing in the command: **cat size.log**
- Command to execute this feature is **./project_analyze.sh sizelog**


