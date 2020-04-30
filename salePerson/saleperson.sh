
##### GLOBAL VARIABLE #####
data=()
subData=() # function return array
sortedIndex=() # function return array
num=0

##################################################################################
##### PARAMETTER FUNCTION #####

function arrIndex() {
	# col < totalCol
	# Fomula: ArrayIndex = col + row*totalCol
	# table width = 2 column

	local col=$1
	local row=$2
	local totalCol=$3
	local index=$(( col + row*totalCol ))
	return $index
}

#function sortData() {	# selection sort
#	local arr=("$@")
#	local length=${#arr[@]}
#	sortedData=($(seq 0 1 $(( length-1 )) ))
#	for((i=0;i<$length;i++)) do
#		for((j=i+1;j<$length;j++)) do
#   			if (( ${arr[$i]} > ${arr[$j]} )); then
#				local temp=${arr[$i]}
#				arr[$i]=${arr[$j]}
#				arr[$j]=$temp
				
#				local test=${sortedData[$i]}				
#				sortedData[$i]=${sortedData[$j]}
#				sortedData[$j]=$test
#			fi
#		done
#	done
#	return 0
#}


function bubbleSort() {
	local arr=("$@")	# get array parametter
	local length=${#arr[@]}
	sortedIndex=($(seq 0 1 $(( length-1 )) )) # insert number 1,2,3,4,... into array
	
	for((i=0;i<$length-1;i++)) do
		for((j=0;j<length-i-1;j++)) do
			if (( ${arr[$j]} > ${arr[$j+1]} )); then
				local temp=${arr[$j]}
				arr[$j]=${arr[$j+1]}
				arr[$j+1]=$temp

				local temp=${sortedIndex[$j]}
				sortedIndex[$j]=${sortedIndex[$j+1]}
				sortedIndex[$j+1]=$temp
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
		subData[$index]=${arr[$i]}	# subData
		((num=num+subData[$index]))	# Calculate total quarterlySale
		((index=index+1))
	done
}



##################################################################################
##### PAPAMETERLESS FUNCTION #####

function writeData() {
	local SalesPerson
	local QuarterlySales
	read -p "Write Sales Person name: " SalesPerson
	read -p "Quarter Sales: " QuarterlySales

	if [[ ! "$QuarterlySales" =~ ^[+-]?[0-9]+([.][0-9]+)?$ ]]; then
		echo "Only number"
	else 
		echo "${SalesPerson// /} $QuarterlySales"  >> data.txt
	fi
}

function readData() {
	# https://unix.stackexchange.com/questions/195224/read-file-word-by-word#comment464849_1
	local index=0
	while read -ra line; do
    		for word in ${line[@]}; do
			data[$index]=$word
			((index=index+1))
    		done
	done < data.txt
}

function readSortedData() {
	readOneCol ${data[@]}		# read one column from table (quarterly sales column) and store it to subData array
	bubbleSort ${subData[@]}	# sort subData array

	local length=${#sortedIndex[@]}
		printf "|\e[4m%15s\e[0m|\e[4m%15s\e[0m|\n" SalesPerson QuarterlySales
	for((i=0;i<length;i++)) do
		local index=${sortedIndex[$i]}
		arrIndex 1 $index 2
		printf "|%15s|%15s|\n" ${data[$(($?-1))]} ${data[$?]}	# show in table form
	done
	echo "Total QuarterlySales: "$num
}



##################################################################################
##### PROGRAM FUNCTION #####

function salePerson() {
	clear
	while true
	do
		readData
		printf "\033[0;96mPlease chose the following option: \n"
		printf "1. Show the number of salespersons \n"
		printf "2. Write and save data to the text file ! \n"
		printf "3. Show data sort by salary! \n"
		printf "4. Show data sort by alphabet! \n"
		printf "5. Exit \n"
		printf "Option: \033[0m"

		local input
		read input
		input=${input// /} 
		if ((input==1)); then
			#bubbleSort
			echo "Total salespersons: "$(( ${#data[@]}/2 ))
 		elif ((input==2)); then
			writeData
		elif ((input==3)); then
			readSortedData
		elif ((input==4)); then
			readOneCol ${data[@]}
			cat data.txt | sort
			echo "Total QuarterlySales: "$num
		elif ((input==5)); then
			break
		else
			echo Invail option!
		fi
		read -p "Press Enter to continiue!!!"
		clear
		# tableManager 12 14
		#readData
	done
}
salePerson

