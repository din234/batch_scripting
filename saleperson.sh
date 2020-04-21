
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

	local col=$1
	local row=$2
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
	num=0

	# col=1; totalCol=2
	for((i=1;i<$length;i+=2)) do
		subData[$index]=${arr[$i]}
		((num=num+subData[$index]))
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
	readOneCol ${data[@]}
	sortData ${subData[@]}

	local length=${#sortedData[@]}
		printf "|\e[4m%15s\e[0m|\e[4m%15s\e[0m|\n" SalesPerson QuarterlySales
	for((i=0;i<length;i++)) do
		local index=${sortedData[$i]}
		arrIndex 1 $index 2
		printf "|%15s|%15s|\n" ${data[$(($?-1))]} ${data[$?]}
	done
	echo "Total QuarterlySales: "$num
}



##################################################################################
##### PROGRAM FUNCTION #####

function salePerson() {
	while true
	do
		readData
		printf "\033[0;96mPlease chose the following option:
1. Show the number of salespersons
2. Write and save data to the text file !
3. Show data sort by salary!
4. Show data sort by alphabet!
5. Exit
Option: \033[0m"
		local input
		read input
		input=${input// /} 
		if ((input==1)); then
			echo "Total salespersons: "$(( ${#data[@]}/2 ))
 		elif ((input==2)); then
			writeData
		elif ((input==3)); then
			readSortedData
		elif ((input==4)); then
			cat data.txt | sort
		elif ((input==5)); then
			break
		else
			echo Invail option!
		fi
		read -p "press enter to continiue!!!"
		clear
		# tableManager 12 14
		#readData
	done
}
