#!/bin/bash

# This is our list of words
array_of_objects=( "Milkshake" "Magazine" "Notebook" "Waffle iron" "Bottle opener" "Barley" "Cassette tape" "Accordion" "Bus" "Cucumber")

# This is the folder where saved boxes will go
data_directory="./data"

object_pool_file="warehouse_of_objects.txt"

print_all_objects(){
	# Shows all the words in the list
	echo -e "The list is as follow below:\n${array_of_objects[@]}\n"
	display_menu_options
}

print_object_at_position() {
	# Asks which spot you want and shows that word
	read -p "please pick a number between 0-9: " position
	echo "item at $position is: ${array_of_objects[$position]} "
	display_menu_options
}

add_new_item(){
	# Lets you type a new word and adds it to the list
	read -p "Please add your desired word to the list: " answer
	array_of_objects+=("$answer")
	echo "The updated list is now: ${array_of_objects[@]}"
	display_menu_options
}

remove_last_item(){
	# Deletes the last word in the list
	unset 'array_of_objects[-1]'
	echo -e "\nYour desired word has been removed\nThe updated list is now: ${array_of_objects[@]}\n"
	display_menu_options
}

delete_item(){
	# Deletes the word at the spot you pick
	read -p "Please type in the position(number) you would like to delete below: " response
	unset "array_of_objects[$response]"
	echo "The updated list is now: ${array_of_objects[@]}"
	display_menu_options
}

save_box(){
	# Asks for a name and saves your list into a file
	read -p "what do you want to save it as?: " user_save_file_name
	filepath="$data_directory/$user_save_file_name.box"
	{
		# This line saves the array in a way Bash can read later
		echo "saved_items=(${array_of_objects[@]@Q})"
	} >"$filepath"
	printf "box save to $filepath\n"
}

load_box(){
	# Opens a saved file and puts its words into the list
	read -p "what did you name your file as?: " user_response
	filepath="$data_directory/$user_response.box"
	if [ -f "$filepath" ]; then
		source "$filepath"
		array_of_objects=("${saved_items[@]}")
		echo -e "\n$user_response loaded\ncurrent items: ${array_of_objects[@]}\n"
	else
		# If the file doesn't exist, show an error
		echo "invalid file name"
	fi
	display_menu_options
}

list_boxes(){
	# Shows all the saved box files in the data folder
	echo "saved boxes:"
	for file in "$data_directory"/*.box; do
		if [ -f "$file" ]; then
			echo "$file"
		fi
	done
	display_menu_options
}

load_object_pool(){
	object_pool=()

	if [ ! -f "$object_pool_file" ]; then
        echo "File not found."
        return 1
    fi
 while read -r line; do
        # ignore empty lines and lines starting with #
        if [[ -z "$line" || "$line" == \#* ]]; then
            continue
        fi

        object_pool+=("$line")
    done < "$object_pool_file"
}

prompt_for_box_size(){
	read -p "How many items will you like to generate?: " amount
}

generate_random_box(){	
	load_object_pool || return
	prompt_for_box_size || return
	generate_random_box
	display_menu_options
}

end_script(){
	# Asks if you want to save before quitting
	read -p "Do you want to save before exiting? (y/n): " confirm
	case $confirm in
		y)
			save_box
			;;
		n)
			exit 0
			;;
		*)
			exit_script   # If you type something else, just exit
			;;
	esac
}


check_for_directory(){
	# This checks if a folder called data exists, and if not, it makes one.
	if [ ! -d "$data_directory" ]; then
		mkdir "$data_directory"
	fi
}

display_menu_options(){
	# This shows all the choices you can pick from and asks you to type one.
	echo -e "
	1. View all items
	2. Print word at position
	3. Add a new word
	4. Delete the last word
	5. Delete a word by position
	6. Save file 
	7. Load file 
	8. List Boxes 
	9. Generate random box from file
	10. Exit
	"
	read -p "Choose an option (1-10): " function_choice
	check_user_input
}

check_user_input(){
	# This looks at what number you typed and runs the matching action.
	case  $function_choice in
		1)
			print_all_objects   # Shows all the words in the list.
			;;
		2)
			print_object_at_position   # Shows the word at the spot you choose.
			;;
		3)
			add_new_item   # Lets you add a new word to the list.
			;;
		4)
			remove_last_item   # Removes the last word from the list.
			;;
		5)
			delete_item   # Removes a word from the spot you pick.
			;;
		6)
			save_box   # Saves your list to a file so you can open it later.
			;;
		7)
			load_box   # Opens a saved file and puts the words in the list.
			;;
		8)
			list_boxes   # Shows all the saved files you have.
			;;
		9)
			generate_random_box   # Picks a random file and shows the words inside.
			;;
		10)
			end_script   # Stops the program.
			;;
		*)
			display_menu_options   # If you typed a wrong number, it shows the menu again.
			;;
	esac	
}

check_for_directory
display_menu_options
