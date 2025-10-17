 #!/bin/bash
 array_of_objects=( "Milkshake" "Magazine" "Notebook" "Waffle iron" "Bottle opener" "Barley" "Cassette tape" "Accordion" "Bus" "Cucumber")
flag=false

print_all_objects(){
	echo "The list is as follow below:"
	echo "${array_of_objects[@]}"
	flag=true
}

print_all_objects

print_object_at_posistion(){
	
	if [ "$flag" = "true" ]; then
	read -p "please pick a number between 0-9: " posistion
	echo "item at $posistion is: ${array_of_objects[$posistion]} "
	fi
}

print_object_at_posistion

add_new_item(){
	read -p "Please add your desired word to the list " answer
	array_of_objects+=("$answer")
	echo "The updated list is now: ${array_of_objects[@]}"
	#read -p "Would you like to add a new object to the list? yes/no" answer
	#if [ "$answer" = "yes" ]; then
		#echo "Please type in your desired below: " response
		#echo "The updated list is now: ${array_of_objects[@]}"
	#elif [ "$answer" = "no" ]; then
		#exit
	#fi
}

add_new_item

delete_last_item(){
	read -p "Would you like to add a new object to the list? yes/no" answer
	#if [ "$answer" = "yes" ]; then
		#echo "Please type in your desired below: " response
		#echo "The updated list is now: ${array_of_objects[@]}"
	#elif [ "$answer" = "no" ]; then
		#exit
	#fi
}