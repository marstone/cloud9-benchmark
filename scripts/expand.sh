#/bin/bash

IND=3
END=$1

if [ -z "$END" ]; then
	END=5
#	echo "END is $END"
fi

#echo $END

SRC='ifelse.c'
TPL='ifelse.tpl' 

echo "try to remove $SRC..."
rm -rf $SRC
echo "copy $TPL to $SRC..."
cp $TPL $SRC

echo "IND is $IND, END is $END"

if [ $IND -le $END ]; then
	echo 'Good, begin expanding...'
else
	echo 'Nothing to do.'
fi

while [ $IND -le $END ]; do
	
	PRE='b'
	VAR=$PRE$IND
	CMD="\tint $VAR; klee_make_symbolic(&$VAR, sizeof($VAR), \"$VAR\"); if($VAR) foo(); else bar();"

	echo -e $CMD
	echo -e $CMD >> $SRC

	IND=$(( $IND + 1 ))

done

echo 'finishing expandation..'

echo -e '\treturn 0;\n}' >> $SRC

echo 'done'
