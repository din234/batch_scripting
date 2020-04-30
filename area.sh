cmWidth=1
cmHeight=1
inchWidth=""
inchHeight=""
##### PARAMETTER FUNCTION #####
function convertCmToInch(){
	if [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ && "$2" =~ ^[0-9]+([.][0-9]+)?$ ]]
	then
		# Insert into global variable
		cmWidth=$1
		cmHeight=$2
		inchWidth=`echo "scale = 10; $1/2.54" | bc`
		inchHeight=`echo "scale = 10; $2/2.54" | bc`
		#return 0;
	else
		echo "Only accept positive real number"
		#return 1;
	fi
}

##### PARAMETTERLESS FUNCTION #####
function widthHeightInput() {
	local width
	local height

	echo Convert cm to inch:
	printf "Write the width of rectangle in cm: "
	read width

	printf "Write the height of rectangle in cm: "
	read height
	convertCmToInch $width $height	# run function
}

function rectangleAreaInCm(){
	local area
	area=`echo "scale = 10; $cmWidth*$cmHeight" | bc`
	echo "The area of rectangle in cm: $area cm^2"
}

function rectangleAreaInInch(){
	local area
	area=`echo "scale = 10; $inchWidth*$inchHeight" | bc`
	echo "The area of rectangle in inch: $area inch^2"
}

#### PROGRAM FUNCTION ####
function area() {
	convertCmToInch $cmWidth $cmHeight
	clear
	while true
	do
		printf "\033[0;96mWidth: \033[0m$cmWidth cm\033[0;96m     Height: \033[0m$cmHeight cm\n"
		printf "\033[0;96mWidth: \033[0m$inchWidth inch\033[0;96m     Height: \033[0m$inchHeight inch\n\n"
		printf "\033[0;96mPlease chose the following option: \n"
		printf "1. Inupt width and height of rectange in cm \n"
		printf "2. Calculate and show Area of rectangle in cm \n" 
		printf "3. Calculate and show Area of rectangle in inch \n"
		printf "4. Exit \n"
		printf "Option: \033[0m"
		local input
		read input
		input=${input// /} 
		if ((input==1)); then
			widthHeightInput
 		elif ((input==2)); then
			rectangleAreaInCm
		elif ((input==3)); then
			rectangleAreaInInch
		elif ((input==4)); then
			break
		else
			echo Invail option!
		fi
		read -p "Press Enter to continiue!!!"
		clear
	done
}
area

