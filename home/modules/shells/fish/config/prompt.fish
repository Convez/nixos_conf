function fish_prompt
	set -l last_status $status
	set -l nix_shell_info (
		if test -n "$IN_NIX_SHELL"
			echo -n (set_color cyan)"<$IN_NIX_SHELL> "
		end
	)

	# Set status: green tick or red x
	set -l shortened_dir (prompt_pwd --full-length-dirs 2)
	set -l status_line 
	if test $last_status -ne 0 
		set status_line (set_color red)"☹"(set_color normal)
	else
		set status_line (set_color green)"☺"(set_color normal)
	end

	echo -n -s "$nix_shell_info"
	echo -n -s -e (set_color green)"$shortened_dir\n$status_line>"
end

function fish_right_prompt
	echo -n -s (set_color yellow) (fish_git_prompt)
end
