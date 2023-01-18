#!/bin/bash
#
#   A simple bash script for creating a java project to the specs of 
#   our class, COMP305 Introduction to Java.
#   By Benjamin Garrett
#   Usage: from the command line, run
#
#   $ java_init_project ProjectName
#
#   the script will run in the current directory and create a directory
#   name ProjectName (or named Application1 if no Project Name is provided.
#   It will also create several subdirectories, an App.java file under src,
#   and a Makefile.

CONFIG="${HOME}/.config/java_init_project.conf"

if ! test -f $CONFIG; then
    echo "Config file not found. Creating in $CONFIG."
    echo -e "AUTHOR=\"My Name\"" >> $CONFIG
fi
source $CONFIG

###### CREATE DIR
createDir() {
    mkdir -p $1
    if test -d $1; then
        echo "Created directory $1"
    else
        echo "Error: failed to create $1"
    fi
    return
}

createFile() {
    touch $1
    if test -f $1; then
        echo "Created directory $1"
    else
        echo "Error: failed to create $1"
    fi
    return
}

###### INCREMENT Filename 
    #Checks if strings ends in one of more digits
    #if yes, increments and returns new string.
    #if not, appends a 1 and returns new string.
incrementFilename()   {
    FILENAME=$1
    NUMBER=`echo $FILENAME|grep -Po '\d+$'`
    if [ "$NUMBER" == "" ]; then
        FILENAME=$FILENAME+"1"
    else
        NUMBER=$((1+$NUMBER))
        FILENAME=`echo $FILENAME|grep -Pv '\d+$'`
        echo "$FILENAME is the inverted result"
        FILENAME="$FILENAME$NUMBER"
        echo "converting to $FILENAME"
    fi
    echo $FILENAME
}



###### CREATEPROJECT FUNCTION
createProject()   {
    PROJECTNAME=$1

    createDir "$PROJECTNAME/src"
    createDir "$PROJECTNAME/bin"
    createDir "$PROJECTNAME/res"
    cd "$PROJECTNAME"

    createFile "src/App.java"
    echo -e "/** Written by $AUTHOR **/
package src; //compiled bin goes into ${PROJECTNAME}/bin/src

class App{
    public static void main(String[] args) {
        System.out.println(\"Hello World! $PROJECTNAME is running!\");
    }
}" >> src/App.java

    createFile "Makefile"
    echo -e "### MAKEFILE FOR PROJECT $PROJECTNAME
files := src/App.java

all: clean compile run

compile: \$(files)
\tjavac \$(files) -d bin

clean:
\t@rm -f bin/*

run:
\tjava -cp bin src.App" >> Makefile
    git init
    return
}


###### MAIN FUNCTION

PROJECTNAME="";
if ["$1" == ""]; then
    PROJECTNAME="JavaApp1"
else
    PROJECTNAME=$1
fi

if test -d "$PROJECTNAME"; then
    echo "$PROJECTNAME exists."
    while test -d "$PROJECTNAME"; do
        PROJECTNAME=$(incrementFilename $PROJECTNAME)
    done
    echo "creating $PROJECTNAME"

else
    read -p "Creating project $PROJECTNAME
    Continue? (Y/n): "
    if [[ "$REPLY" == "" || "$REPLY" == "Y"|| "$REPLY" == "y" ]]; then
        echo -e "Confirmed. Generating..."
        createProject $PROJECTNAME
    else
        echo -e "Exiting..."
    fi
fi
echo -e "Complete."
