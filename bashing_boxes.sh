 #!/bin/bash
 array_of_objects=( "Milkshake" "Magazine" "Notebook" "Waffle iron" "Bottle opener" "Barley" "Cassette tape" "Accordion" "Bus" "Cucumber")
data_directory="./data"
check_for_directory(){
	if [ ! -d "$data_directory" ]; then
		mkdir "$data_directory"
	fi
}

display_menu_options(){
	echo "1. View all items"
    echo "2. Print word at position"
    echo "3. Add a new word"
    echo "4. Delete the last word"
    echo "5. Delete a word by position"
    echo "6. Exit"
    read -p "Choose an option (1-6): " function_choice
    echo
    check_user_input
}


check_user_input(){
	case  $function_choice in

		1)

		print_all_objects
		;;

		2)

		print_object_at_position
		;;

		3)

		add_new_item
		;;

		4)

		remove_last_item
		;;

		5)

		delete_item
		;;

		6)

		end_script
		;;

		*)
		display_menu_options
	    ;;
	esac

		
}

print_all_objects(){
	echo "The list is as follow below:"
	echo "${array_of_objects[@]}"
	display_menu_options
}
print_object_at_position() {
	read -p "please pick a number between 0-9: " position
	echo "item at $position is: ${array_of_objects[$position]} "
	display_menu_options
}
add_new_item(){
	read -p "Please add your desired word to the list: " answer
	array_of_objects+=("$answer")
	echo "The updated list is now: ${array_of_objects[@]}"
	display_menu_options
}
remove_last_item(){
	unset 'array_of_objects[-1]'
	echo "Your desired word has been removed"
	echo "The updated list is now: ${array_of_objects[@]}"
	display_menu_options
}
delete_item(){
	read -p "Please type in the position(number) you would like to delete below: " response
	unset "array_of_objects[$response]"
	echo "The updated list is now: ${array_of_objects[@]}"
	display_menu_options
}

save_box(){
	read -p "what do you want to save it as?: " user_save_file_name
	filepath=" $data_directory/$user_save_file_name.box "
	{
		echo "saved_items=(${array_of_objects[@]@Q}"

	} >"$filepath"
	echo "box save to $filepath"
}

load_box(){
	read -p "what did you name your file as?: " user_response
	filepath=" $data_directory/$user_response.box "
	if [ -f "$filepath" ]; then
		source "$filepath"
		array_of_objects=("${saved_items[@]}")
		echo " $user_response loaded"
		echo "current items: ${array_of_objects[@]}"
	fi
}
load_box

end_script(){
	exit 0
} 
display_menu_options

