function crontabCommand(){
	# https://www.geeksforgeeks.org/crontab-in-linux-with-examples/
	# Format MIN HOUR DOM MON DOW CMD

}

function tarCommand(){
	#https://www.tecmint.com/18-tar-command-examples-in-linux/
	tar cvzf test.tgz ./
}

##################################################################################
##### PROGRAM FUNCTION #####

function manage() {
	while true
	do
		readData
		printf "\033[0;96mPlease chose the following option:
1. Run tar command
2. Two
3. Three
4. Four
5. Exit
Option: \033[0m"
		local input
		read input
		input=${input// /} 
		if ((input==1)); then
			tarCommand
 		elif ((input==2)); then
			echo "Two"
		elif ((input==3)); then
			echo "Three"
		elif ((input==5)); then
			break
		else
			echo Invail option!
		fi
		read -p "press enter to continiue!!!"
		clear
	done
}