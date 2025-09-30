#!/usr/bin/env fish

function show_message
    echo (set_color green)"--> "$argv(set_color normal)
end

set -l config_file "$HOME/acronyms.md"
set -l search_prompt "Search/Add Key (acronyms):"

if not test -f "$config_file"
    mkdir -p (dirname $config_file)
    touch "$config_file"
    show_message "Created new config file: $config_file"
end

set -l keys (
    cat $config_file | \
    string trim
)
set -l line_num (
  cat $config_file | wc -l
)
if test $line_num -gt 5
  set  line_num 5
end
show_message $line_num

set -l selection (
    printf '%s\n' $keys | \
    /home/convez/.nix-profile/bin/wofi -d -L $line_num -p "$search_prompt" -k /dev/null
)

if test -z "$selection"
    show_message "Operation cancelled."
    exit 0
end
show_message $selection


set -l existing_entry (
    grep -e "$selection" $config_file | \
    string trim
)

if not test -z $existing_entry
  show_message "Key '$selection' found. Value is: '$existing_value'"
else
  show_message "Key $selection not found. Prompting for new definition addition"
  
  set -l value_prompt "Enter VALUE for new key '$selection':"
  set -l new_value (echo "" | /home/convez/.nix-profile/bin/wofi -d -L 1 -p "$value_prompt" -k /dev/null) 
  if test -z $new_value
    show_message "Addition of new value cancelled. No new entry."
  else
    echo "$selection = $new_value" >> $config_file
  end

end
