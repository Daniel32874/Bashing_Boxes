#!/bin/bash
array_of_objects=( "Milkshake" "Magazine" "Notebook" "Waffle iron" "Bottle opener" "Barley" "Cassette tape" "Accordion" "Bus" "Cucumber")
data_directory="./data"

check_for_directory(){
	if [ ! -d "$data_directory" ]; then
		mkdir "$data_directory"
	fi
}
display_menu_options(){
	echo -e "
	1. View all items
	2. Print word at position
	3. Add a new word
	4. Delete the last word
	5. Delete a word by position
	6. Save file 
	7. Load file 
	8. List Boxes 
	9. Exit
	"
	read -p "Choose an option (1-9): " function_choice
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
			save_box
			;;
		7)
			load_box
			;;
		8)
			list_boxes
			;;
		9)
			end_script
			;;
		*)
			display_menu_options
			;;
	esac	
}
print_all_objects(){
	echo -e "The list is as follow below:\n${array_of_objects[@]}\n"
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
	echo -e "\nYour desired word has been removed\nThe updated list is now: ${array_of_objects[@]}\n"
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
	filepath="$data_directory/$user_save_file_name.box"
	{
		echo "saved_items=(${array_of_objects[@]@Q})"
	} >"$filepath"
	printf "box save to $filepath\n"
}
load_box(){
	read -p "what did you name your file as?: " user_response
	filepath="$data_directory/$user_response.box"
	if [ -f "$filepath" ]; then
		source "$filepath"
		array_of_objects=("${saved_items[@]}")
		echo -e "\n$user_response loaded\ncurrent items: ${array_of_objects[@]}\n"
	else
		echo "invalid file name"
	fi
	display_menu_options
}
list_boxes(){
	echo "saved boxes:"
	for file in "$data_directory"/*.box; do
		if [ -f "$file" ]; then
			echo "$file"
		fi
	done
	display_menu_options
}
end_script(){
	read -p "Do you want to save before exiting? (y/n): " confirm
	case $confirm in
		y)
			save_box
			;;
		n)
			exit 0
			;;
		*)
			exit_script
			;;
	esac
}
check_for_directory
display_menu_options


