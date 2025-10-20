 #!/bin/bash
 array_of_objects=( "Milkshake" "Magazine" "Notebook" "Waffle iron" "Bottle opener" "Barley" "Cassette tape" "Accordion" "Bus" "Cucumber")
flag=false
echo "1. View all items"
    echo "2. View an item by position"
    echo "3. Add a new word"
    echo "4. Delete the last word"
    echo "5. Delete a word by position"
    echo "6. Exit"
    read -p "Choose an option (1-6): " function_choice
    echo

   case  $function_choice in

1)
print_all_objects(){
	echo "The list is as follow below:"
	echo "${array_of_objects[@]}"
	flag=true
}

print_all_objects
;;

2)
print_object_at_position(){
	
	if [ "$flag" = "true" ]; then
	read -p "please pick a number between 0-9: " position
	echo "item at $position is: ${array_of_objects[$position]} "
	fi
}
;;

3)
print_object_at_position

add_new_item(){
	read -p "Please add your desired word to the list: " answer
	array_of_objects+=("$answer")
	echo "The updated list is now: ${array_of_objects[@]}"
}

add_new_item
;;

4)
remove_last_item(){
	unset 'array_of_objects[-1]'
	echo "Your desired word has been removed"
	echo "The updated list is now: ${array_of_objects[@]}"
}
remove_last_item
;;

5)
delete_item(){
	read -p "Please type in the position(number) you would like to delete below: " response
	unset "array_of_objects[$response]"
	echo "The updated list is now: ${array_of_objects[@]}"
}
delete_item
;;

6)
end_script(){
	exit 0
}
end_script
;;
esac
