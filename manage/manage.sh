TIME="* * * * *"
SOURCE=$PWD
DESTINATION=$PWD
ARCHIVE_NO=0 	# to prevent overwrite

CRONJOB="$TIME cd $SOURCE && tar -zcvf $DESTINATION/archive$ARCHIVE_NO.tar.gz *"


##################################################################################
##### PARAMETTER FUNCTION #####

# Manage Archive file
function checkDirectionExist(){	#	parametter:()
	local DIRECTORY=$PWD

	if [[ ! -z "$1" ]];then		# check parametter value not empty
		DIRECTORY=$1
	fi

	if [ -d "$DIRECTORY" ]; then 	# check directories is exist or not
		return 0
	else
		echo "Directories not exist !!!"
		return 1
	fi
	return 0
}

function setTime(){
	if [[ ! "$1" =~ ^[0-9]+[0-9]+$ ]]; then
		echo "Invaild format for minute!"
		return 1
	elif [[ ! "$2" =~ ^[0-9]+[0-9]+$ ]]; then
		echo "Invaild format for hours!"
		return 1
	elif [[ ! "$3" =~ ^[0-9]+[0-9]+$ ]]; then
		echo "Invaild format for day!"
		return 1
	elif [[ ! "$4" =~ ^[0-9]+[0-9]+$ ]]; then
		echo "Invaild format for month!"
		return 1
	fi

	if (( $1 > 59 )); then
		echo "minute must be between 0-59"
		return 1
	elif (( $2 > 23 )); then
		echo "hour must be between 0-23"
		return 1
	elif (( $3 == 0 || $3 > 31 )); then
		echo "day must be between 1-31"
		return 1
	elif (( $4 == 0 || $4 > 12 )); then
		echo "month must be between 1-12"
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

#function checkTime(){
#	local check
#	check=${@}
	
#	local min
#	local hour
#	local day
#	local mon
#	local remain
#	local temp
#	while IFS=" " read -r min hour day mon remain
#	do
#		temp="$min $hour $day $mon *"
#		if [[ "$check" == "$temp" ]]; then
#			return 1
#		fi
#	done < "time"
#	return 0
#}

##################################################################################
##### PAPAMETERLESS FUNCTION #####

# ARCHIVE
function checkArchive(){ #	reading line number of cronjob file and insert it into ARCHIVE_NO
	local index=0
	local line
	while IFS= read -r line
	do
		((index=index+1))
	done < "time"
	ARCHIVE_NO=$index
}

function updateCronjob(){
	CRONJOB="$TIME cd $SOURCE && tar -zcvf $DESTINATION/archive$ARCHIVE_NO.tar.gz *"
}

function sourceFile(){
	echo "Default source location: "$SOURCE
	local input

	printf "Set new source directory: "
	read input
	if checkDirectionExist $input; then
		SOURCE=$input
		updateCronjob
	fi
}

function destination(){
	echo "Default destination: "$DESTINATION
	local input
	printf "Set new destination directory to archive file: "
	read input
	if checkDirectionExist $input; then
		DESTINATION=$input
		updateCronjob
	fi
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
	#if checkTime $TIME then
		echo $CRONJOB >> time
		crontab time	# read crontab file to cronjob
		echo "Cronjob update successfully!"
	#else
		#echo "Time bound exception!!!"
	#fi
	set +f
}


# USER
function addGroup(){
	echo "test"
}


function addUser(){
	local username

	printf "Write username: "
	read username
	sudo useradd $username
	echo "New user added!"
}

function deleteUser() {
	local username
	
}

function editUser() {
	local username
}



##################################################################################
##### PROGRAM FUNCTION #####
function archive(){
	clear
	while true
	do	
		checkArchive
		updateCronjob

		set -f
		echo $CRONJOB
		set +f
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
		elif ((input==3)); then
			destination
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



function user(){
	clear
	while true
	do
		updateCronJob
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
		elif ((input==5));then
			echo "four"
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
		updateCronjob
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
manage