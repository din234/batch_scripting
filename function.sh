# while true ; do
function phan1 {
	echo Convert cm to inch:
	echo Write width:
	read w
	# echo Write height:
	# read h
	if [ $w -gt 0 ]
	then
		echo width is:
		echo "scale = 10; $w/2.56" | bc
		#echo height is:
		#echo "scale = 10; $x/2.56" | bc
	else 
		echo Not Ok
	fi

	#echo Very good $varname
		
	
	#for ((k = 0; k < 50; ++k)); do
	#	a=$((2*k + 1))
	#	echo "$a"
	#done	
	
	#i=3.12
	#while true; do	
	#	let "i=i*2"
	#	a=$(2*i + 1)
	#	echo $i
	#done
}

