#!/bin/bash

# Default values
length=20
special=true
numbers=true
alphabet=true
uppercase=true
lowercase=true
help_message="""
Usage: generate_pass.sh [options]
Options:
    -l  Length of password (default: 12)
    -s  Include special characters
    -n  Include numbers
    -a  Include alphabet
    -u  Include uppercase letters
    -c  Include lowercase letters
    -h  Show this help message
"""
# write a help message and write when -h is passed

# Parse parameters
while getopts ":l:s:n:a:u:c:h:" opt; do
    case $opt in
        l) length=$OPTARG;;
        s) special=true;;
        n) numbers=true;;
        a) alphabet=true;;
        u) uppercase=true;;
        c) lowercase=true;;
        h) echo "$help_message"; exit 0;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            echo "$help_message" >&2
            exit 1
            ;;
    esac
done
echo "length: $length"
echo "special: $special"
echo "numbers: $numbers"
echo "alphabet: $alphabet"
echo "uppercase: $uppercase"
echo "lowercase: $lowercase"

# Check if at least one option is selected
if ! $special && ! $numbers && ! $alphabet && ! $uppercase && ! $lowercase; then
    echo "You must choose at least one option"
    echo "$help_message" >&2
    exit 1
fi

# Define character sets based on selected options
charset=''
if $special; then charset+='!@#$%^&*()_+{}|:<>?='; fi
if $numbers; then charset+='0-9'; fi
if $alphabet; then charset+='A-Za-z'; fi
if $uppercase; then charset+='A-Z'; fi
if $lowercase; then charset+='a-z'; fi
echo "charset: $charset"
# Generate password
password=$(tr -dc "$charset" < /dev/urandom | head -c "$length")

# Copy password to clipboard
echo -n "$password" | xclip -selection clipboard
echo "Password: $password"
echo "Generated password copied to clipboard!"
exit 0



