TIME="* * * * *"
SOURCE=$PWD
DESTINATION=$PWD
CRONJOB="$TIME cd $SOURCE && tar -zcvf $DESTINATION/archive.tar.gz *"


##################################################################################
##### PARAMETTER FUNCTION #####

# Manage Archive file
function checkDirectionExist(){
	echo $1
	local DIRECTORY=$PWD

	if [[ ! -z "$1" ]];then
		DIRECTORY=$1
	fi

	if [ -d "$DIRECTORY" ]; then 
		SOURCE=$DIRECTORY
		return 0
	else
		echo "not exist"
		return 1
	fi
	return 0
}

function setTime(){
	if [[ ! "$1" =~ ^[0-9]+[0-9]+$ ]]; then
		echo "one"
		return 1
	elif [[ ! "$2" =~ ^[0-9]+[0-9]+$ ]]; then
		echo "two"
		return 1
	elif [[ ! "$3" =~ ^[0-9]+[0-9]+$ ]]; then
		echo "three"
		return 1
	elif [[ ! "$4" =~ ^[0-9]+[0-9]+$ ]]; then
		echo "four"
		return 1
	fi

	#set -f
	local MIN=$1		# MINUTES
	local HOUR=$2		# HOUR
	local DOM=$3		# DAY OF MONTH
	local MONTH=$4		# MONTH
	local DOW="*"
	TIME="$MIN $HOUR $DOM $MONTH $DOW"
	return 0
	#set +f
}

##################################################################################
##### PAPAMETERLESS FUNCTION #####

# ARCHIVE
function updateCronjob(){
	CRONJOB="$TIME cd $SOURCE && tar -zcvf $DESTINATION/archive.tar.gz *"
}

function sourceFile(){
	echo "Default location: "$SOURCE
	local input

	printf "Set new source directory: "
	read input
	if checkDirectionExist $input; then
		updateCronjob
	fi
}

function destinationFile(){
	local input
}

function updataTime(){
	local MIN
	local HOUR
	local DOM
	local MONTH

	printf "Write min: "
	read MIN

	printf "Write hours: "
	read HOUR	

	printf "Write days: "
	read DOM

	printf "Write month: "
	read MONTH
	
	MIN=${MIN// /} 
	HOUR=${HOUR// /} 
	DOM=${DOM// /} 
	MONTH=${MONTH// /} 

	if setTime $MIN $HOUR $DOM $MONTH; then
		updateCronjob
	fi
}

function writeCronjob() {
	set -f
	echo $CRONJOB >> time
	set +f
	crontab time
	#if [[ ! "$QuarterlySales" =~ ^[+-]?[0-9]+([.][0-9]+)?$ ]]; then
	#	echo "Only number"
	#else 
	#	echo "${SalesPerson// /} $QuarterlySales"  >> time
	#fi
}


# USER


##################################################################################
##### PROGRAM FUNCTION #####
function archive(){
	clear
	while true
	do
		set -f
		echo $CRONJOB
		set +f
		readData
		printf "\033[0;96mPlease chose the following option: \n"
		printf "1. Time to archive the file \n"
		printf "2. Source file \n"
		printf "3. Destination \n"
		printf "4. Save to crontab \n"
		printf "5. Exit \n"
		printf "Option: \033[0m"
		local input
		read input
		input=${input// /}
		if ((input==1)); then
			updataTime
		elif ((input==2)); then
			sourceFile
		elif ((input==4));then
			writeCronjob
		elif ((input==5));then
			break
		else
			echo Invail option!
		fi
		read -p "Press enter to continiue!!!"
		clear
	done
}



function addGroup(){
	echo "test"
}


function addUser(){
	local username

	printf "Write username: "
	read username
	useradd $username
	echo "New user added!"
}






function user(){
	clear
	while true
	do
		readData
		printf "\033[0;96mPlease chose the following option: \n"
		printf "1. Add new group \n"
		printf "2. Add new user \n"
		printf "3. Delete user \n"
		printf "4. Delete group \n"
		printf "5. Edit user \n"
		printf "6. Edit group \n"
		printf "7. Exit \n"
		printf "Option: \033[0m"
		local input
		read input
		input=${input// /}
		if ((input==1)); then
			echo "one"
		elif ((input==2)); then
			addUser
		elif ((input==3));then
			echo "three"
		elif ((input==4));then
			writeCronjob
		elif ((input==7));then
			break
		else
			echo Invail option!
		fi
		read -p "Press enter to continiue!!!"
		clear
	done
}





function manage() {
	clear
	while true
	do
		readData
		printf "\033[0;96mPlease chose the following option: \n"
		printf "1. Archive \n" 
		printf "2. User \n"
		printf "3. Exit \n"
		printf "Option: \033[0m"
		local input
		read input
		input=${input// /} 
		if ((input==1)); then
			archive
 		elif ((input==2)); then
			user
		elif ((input==3)); then
			break
		else
			echo Invail option!
		fi
		read -p "Press Enter to continiue!!!"
		clear
	done
}