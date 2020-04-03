source function.sh
source saleperson.sh

function fun1() {
	return 1
}

function fun2() {
	return 0
}

function main() {
	while true
	do
		local input
		read -p "Please chose from 1 to 10: " input
		if ((input==1)); then
			salePerson
			#readData
			#sortData "${array[@]}"
			#echo ${arr[*]}
			#if fun2; then
			#	fun1
			#	echo $?
		elif ((input==2)); then
			echo two
		elif ((input==3)); then
			echo three
		elif ((input==4)); then
			echo four
		else
			echo Nani
		fi

		read -p "Continiue???" input
		if ((input==1)); then
			break
		fi
		clear
	done
	#echo $res
}
main