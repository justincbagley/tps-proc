#!/bin/sh

##--------------------------------------------------------------------------------------##
##--SHELL SCRIPT FOR PARSING TPS FILES TO GET CLASSIFIER VARIABLES FROM JPEG FILENAMES--##
#---This code was written July 8, 2016 by:         -------------------------------------##
#---Justin C. Bagley, Ph.D.                        -------------------------------------##
#---Departamento de Zoologia                       -------------------------------------##
#---Universidade de Brasília, Brasília, DF, Brazil -------------------------------------##
#---For questions, please email jcbagley@unb.br    -------------------------------------##
##--------------------------------------------------------------------------------------##

echo "
##########################################################################################
#                            tps2classifiers v1.0, July 2016                             #
##########################################################################################
"
#
#
#
##---------------------- STEP #1: GET & CLEAN IMAGE FILENAME(S) ------------------------##
for i in ./*.TPS                                                        ## Look for .TPS input files in current directory.
	do 
	echo $i
	grep -n "IMAGE=" ${i} > ${i}_rawNames1.txt                          ## Extract image filenames from TPS file by getting lines starting with "IMAGE=".
		awk -F"=" '{print $NF}' ${i}_rawNames1.txt > ${i}_rawNames2.txt	## Previous line has junk at beginning; remove it by using AWK to get filename following the equals sign.
			sed 's/.jpg//' ${i}_rawNames2.txt > ${i}_imgNames.txt		## Use sed to remove the extension from each filename.
	rm ${i}_rawNames1.txt ${i}_rawNames2.txt							## Remove temporary files created during preceding operations and rename output files so that they don't include initial .TPS file extensions.
done
#
#
#
##-------- STEP #2: PARSE FILENAME(S) INTO CLASSIFIER FILE(S) FOR MorphoJ or R ---------##
##--EXTRACT FILENAMES of "....TPS_imgNames.txt" files output from step 1 operations above,
##--search and replace underscores with tab characters, and output to new "classifiers"
##--files:
for j in ./*.TPS_imgNames.txt	# This looks for input files with the .TPS_imgNames.txt extension/file type output in the first step.
	do 
	echo $j
	sed -E 's/\_(....)\_(..)\_(...)/	\1	\2	\3/g' <${j} > ${j}_classifiers.txt
done
#
#
##--ADD COLUMN OF INTEGERS FROM 0 to x for x# of rows in each classifier file... in order
##--to match default IDs (0 to x) in MorphoJ. THEN ADD HEADER ROWS that match the contents
##--of each column to each classifier file. LAST, convert lines from double to single
##--spacing by removing all lines containing only the end of line character \r.
echo "ID	Code	Site	Area	Species" > header.txt	## Make header row. Change these codes as needed.
#
for k in ./*.TPS_imgNames.txt_classifiers.txt
	do
	echo $k
	nl -nln -v0 ${k} > ${k}_numCol.txt
		for l in ./*_numCol.txt
			do 
			echo $l
			cat ./header.txt ${l} > ${l}_out.final.txt
		done
				for m in ./*_out.final.txt
					do 
					echo $m
					sed '/^$/d' ${m} > ${m}.tmp
					mv ${m}.tmp ${m}_singleSpaced.txt
				done
		for n in ./*_singleSpaced.txt
			do 
			echo $n
			sed -E 's/     	/	/g; s/    	/	/g; s/   	/	/g' <${n} > ${n}_tabFix.txt
		done
done
#
#
#
##-------- STEP #3: CLEANUP FILES & FILENAMES (e.g. REMOVE UNNECESSARY FILES) ----------##
##--The following code uses a for loop to rename the final output files that will be kept,
##--and then uses rm to remove any unnecessary files.
for o in *_out.final.txt_singleSpaced.txt_tabFix.txt
	do
	mv $o ${o/.TPS_imgNames.txt_classifiers.txt_numCol.txt_out.final.txt_singleSpaced.txt_tabFix.txt/.classifiers.txt}
done
rm ./header.txt
rm ./*.TPS_imgNames.txt
rm ./*.TPS_imgNames.txt_classifiers.txt
rm ./*.TPS_imgNames.txt_classifiers.txt_numCol.txt
rm ./*.TPS_imgNames.txt_classifiers.txt_numCol.txt_out.final.txt
rm ./*.TPS_imgNames.txt_classifiers.txt_numCol.txt_out.final.txt_singleSpaced.txt
#
#
#
##--------------------------------------------------------------------------------------##

exit 0
