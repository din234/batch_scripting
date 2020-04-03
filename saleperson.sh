
##### GLOBAL VARIABLE #####

x=7
y="dangit"
# array=()
array=(1 5 3 2 6 7 8 4 11 3 2 1 5 3 5 6 76 6 6)

data=()
subData=() # function return array
sortedData=() # function return array


##################################################################################
##### PARAMETTER FUNCTION #####

function arrIndex() {
	# col < totalCol
	# Fomula: ArrayIndex = col + row*totalCol
	# table width = 2 column

	local row=$1
	local col=$2
	local totalCol=$3
	local index=$(( col + row*totalCol ))
	return $index
}

function sortData() {
	local arr=("$@")
	local length=${#arr[@]}
	sortedData=($(seq 0 1 $(( length-1 )) ))

	for((i=0;i<$length;i++)) do
		for((j=i+1;j<$length;j++)) do
   			if (( ${arr[$i]} > ${arr[$j]} )); then
				local temp=${arr[$i]}
				arr[$i]=${arr[$j]}
				arr[$j]=$temp
				
				local test=${sortedData[$i]}				
				sortedData[$i]=${sortedData[$j]}
				sortedData[$j]=$test
			fi
		done
	done
	return 0
}

function readOneCol() {
	local arr=("$@")
	local length=${#arr[@]}
	local index=0

	# col=1; totalCol=2
	for((i=1;i<$length;i+=2)) do
		subData[$index]=${arr[$i]}
		((index=index+1))
	done
}



##################################################################################
##### PAPAMETERLESS FUNCTION #####

function Func {
	FILE="data.txt"
	OUT=$(awk '{print $2}' $FILE)

	echo $OUT
	
	#echo "*** File - $FILE contents ***"
	#cat $FILE

	#for ip in $OUT ;do

	#	echo $ip
	#done
}

function writeData() {
	local SalesPerson
	local QuarterlySales
	read -p "Write Sales Person name: " SalesPerson
	read -p "Quarter Sales: " QuarterlySales

	if [[ ! "$QuarterlySales" =~ ^[+-]?[0-9]+([.][0-9]+)?$ ]]; then
		echo "Only number"
	else 
		echo "$SalesPerson $QuarterlySales" >> data.txt
	fi
}

function readData() {
	# https://unix.stackexchange.com/questions/195224/read-file-word-by-word#comment464849_1
	#row=0
	#col=0
	#pos=row+col*2
	
	local index=0
	while read -ra line; do
    		for word in ${line[@]}; do
			data[$index]=$word
			((index=index+1))
    		done
	done < data.txt
	
	#echo ${psd[@]}
}

function readSortedData() {
	readOneCol ${data[@]}
	sortData ${subData[@]}
	echo ${sortedData[@]}

	local length=${#sortedData[@]}
	for((i=0;i<length;i++)) do
		local index=${sortedData[$i]}
		echo ${subdata[$index]}
	done
}



##################################################################################
##### PROGRAM FUNCTION #####

function salePerson() {
	while true
	do
		readData
		local input
		read -p "Please chose from 1 to 5: " input
		if ((input==1)); then
			writeData
		elif ((input==2)); then
			echo "test"
		elif ((input==3)); then
			readSortedData
		elif ((input==4)); then
			echo four
		else
			echo Nani
		fi
		# tableManager 12 14
		#readData
	done
}
