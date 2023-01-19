By Benjamin Garrett

A simple bash script for creating a java project to the specs of 
our class, COMP305 Introduction to Java.

REQUIREMENTS:
bash, grep, sed

INSTALLATION:
Simply move script into any folder in your bin $PATH. /usr/local/bin or 
$HOME/.bin is recommended.

USAGE:
Usage: from the command line, run

$ java_init_project ProjectName

the script will run in the current directory and create a directory
name ProjectName (or named Application1 if no Project Name is provided.
It will also create several subdirectories, an App.java file under src,
and a Makefile.
