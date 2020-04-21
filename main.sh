source function.sh
source saleperson.sh
source manage.sh

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
		printf "\033[0;96mPlease chose the following option:
1. SalesPersons
2. Archive
3. Three
4. Exit
Option: \033[0m"
		read input
		if ((input==1)); then
			clear
			salePerson
		elif ((input==2)); then
			clear
			manage
		elif ((input==3)); then
			echo three
		elif ((input==4)); then
			clear
			break
		else
			echo Invail Input
		fi
		read -p "Continiue???"
		clear
	done
	#echo $res
}
main