#! /bin/sh

dataTime=0
dataAmt=0
decryptionTime=0
decryptionAmt=0

dedel="md:"
dadel="dp:"

while read line; do
	if [[ "${str}" == *dadel* ]] ;then
		tempTime=${line%"$dadel"}
	
		if [$tempTime != 0]; then
			$dataAmt+=1
			$dataTime+=$tempTime
		fi
		$dataTime+=1
	fi
	 
	if [[ "${str}" == *dedel* ]] ;then
		tempTime=${line%"$dedel"}
	
		if [$tempTime != 0]; then
			$decryptionAmt+=1
			$decryptionTime+=$tempTime
		fi
			
	fi
done < "log/SonarDaemon.out"

startStr="Data takes an average of "

resultDec=$decryptionTime/$decryptionAmt
resultData=$dataTime/$dataAmt

echo $startStr + $resultData + " milliseconds to process"
echo $startStr + $resultDec + " milliseconds to decrypt"
