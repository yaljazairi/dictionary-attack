#!/bin/bash

# Cracking Tool with Dictionary Attack concept
# Command used to run the program:: bash passCrack.sh  ,,, or simply allow execution rights using chmod 744 passCrack.sh
# Run ./passCrack.sh

# Hashes to compare with
hashes=( '$1$O7v0C2lZ$E8qLtddshWTpEF9EJ8Nmi1' 'hVEumPED$w6afIaNNrvKfGFSsmCcHT/'
	 	  	'$1$XJwb3vQN$PRjRzJVTB1PWIpw1M8uqO/' '$1$xkoLaWW0$bJib5w2vV9CClcSfsOjl20' 
	   		'$1$0ngrMRaj$4mXDUbpsVQgyGpsRxiSy/1' '$1$.OFMxzzD$yhGV2j9.sUpYEzHKPsoNd/'
           	'$1$Cx3h/d.G$PxUomtQgO/n9T0eGVweCH1' '$1$S2QJ/DwC$1CWqAcPIUpBKbyR4S8o/W1'
           	'$1$eAnz2eeh$Bzd4kfKMZkIvZ1KTTudQb1' '$1$1aaPttrp$I2Ap/roBfRoWfx3BWRzZq.'
			'$1$tMznqlt9$7ieEwjFr5tuMU4CXX2SFX0' '$1$C1rJw.uq$1XBONI7qTNh1DHb5RBipv1'
           	'$1$UL8CSHra$KRplQCo26heOxlqu3UuGR1' '$1$ltX9YS4X$eNhKCEpH43Oz4SVYewY2J/')

# Array of Salt Variants
salt_array=(	'O7v0C2lZ' 'hVEumPED' 'XJwb3vQN'
			'xkoLaWW0' '0ngrMRaj' 'Cl5hww4i'
			'.OFMxzzD' 'Cx3h/d.G' 'S2QJ/DwC'
			'eAnz2eeh' '1aaPttrp' 'tMznqlt9'
			'C1rJw.uq' 'UL8CSHra' 'ltX9YS4X')

# Name of cyber victims
names_array=(	'Christine.Blanchard' 'Philip.Castillo' 'Lacey.Deleon'
	  		'Andrew.Short' 'Troy.Taylor' 'Ellie.Burns'
	  		'Ricky.Crawford ' 'Nadia.Watson' 'Andreas.Scheuer'
	  		'Fleur.Bright' 'Xander.Warren' 'Charley.Mueller'
	  		'Alexander.Holden ' 'Anja.Maria' 'Clio.Torres')

# INPUT variable holds the words of the dictionary, OUTPUT is file where my results will be extra saved!
# INPUT=/usr/share/dict/words
INPUT=word.txt
OUTPUT=passwords.txt
#salt = salt_array[0] , then salt = salt_array[1] usw..
# line is what is written in each line of the INPUT

j=1
for salt in "${salt_array[@]}"
do
	while read line
	do
		for i in {0..13}
		do
			MD5_HASH=$(openssl passwd -1 -salt $salt $line)
			if [ "$MD5_HASH" == "${hashes[$i]}" ]; then
				WHO = $(echo "${names_array[$i]} has the Password : $line")
				# Delete the old already existing OUTPUT file, for the validity of the results!
				if test -f "$OUTPUT"; then
					echo "OUTPUT-Data already existed. Old data is going to be exchanged with the new ones"
					echo
					rm $OUTPUT
				fi
				echo "Results are as follows :"
				echo "------------------------"
				echo $WHO
				echo $WHO >> $OUTPUT		# Adding each new result to OUTPUT
			fi
		done
		# j variable checks which line of the input file was reached... In order to check the flow of my program, if I want...
		echo "j : $j">achieved_word.txt
		j=$(($j+1))
	#done < data.txt
	done < $INPUT
done