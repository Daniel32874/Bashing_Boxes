 #!/bin/bash
 word=( "Milkshake" "Magazine" "Notebook" "Waffle iron" "Bottle opener" "Barley" "Cassette tape" "Accordion" "Bus" "Cucumber")
echo "${word[@]}"

read -p "please pick a number between 0-9: " pos
echo "item at $pos is: ${word[$pos]} "
