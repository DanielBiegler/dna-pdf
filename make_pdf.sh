#!/bin/bash

# 1. /path/master.odt
# 2. /path/sequence_content.txt
# 3. /path/output.odt
if [ $# -lt 3 ]; then
	echo "You need 3 arguments: /path/master.odt, /path/sequence_content.txt, /path/output.odt"
	exit 1
fi

echo "Creating content.xml"
# unpack to stdout	  # replace text with REPLACEME on seperate line     # replace with file contents
unzip -p $1 content.xml | perl -p -e 's/<text:p.*?(?=<\/o)/\nREPLACEME\n/' | sed -e "/REPLACEME/{r $2" -e 'd}' > content.xml

echo "Copying $1 to $3"
cp $1 $3

echo "Adding content.xml to $3"
zip $3 content.xml

echo "Remove content.xml"
rm content.xml

echo "Creating PDF. This can take a while"
time libreoffice --convert-to "pdf" $3
