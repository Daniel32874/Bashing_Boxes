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
	read -p "Please add your desired word to the list: " answer
	array_of_objects+=("$answer")
	echo "The updated list is now: ${array_of_objects[@]}"
}

add_new_item

remove_last_item(){
	unset 'array_of_objects[-1]'
	echo "Your desired word has been removed"
	echo "The updated list is now: ${array_of_objects[@]}"
}
remove_last_item

delete_item(){
	read -p "Please type in the world you would like to delete below: " response
	unset "array_of_objects[$response]"
	echo "The updated list is now: ${array_of_objects[@]}"
}
delete_item