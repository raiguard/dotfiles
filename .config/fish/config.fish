set fish_greeting

alias n nnn
alias k "kks edit"
alias sk "sudoedit"
alias dlg "lazygit --work-tree ~"
alias lg lazygit
alias t "todoist-cli --color"
alias f1 /home/rai/dev/factorio/1/bin/x64/factorio
alias f2 /home/rai/dev/factorio/2/bin/x64/factorio
alias f3 /home/rai/dev/factorio/3/bin/x64/factorio
alias f4 /home/rai/dev/factorio/4/bin/x64/factorio
alias fd11 /home/rai/dev/projects/wube/Factorio-1.1/bin/Debugx64Clang/factorio-run
alias fr11 /home/rai/dev/projects/wube/Factorio-1.1/bin/Releasex64Clang/factorio-run
alias fd12 /home/rai/dev/projects/wube/Factorio-1.2/bin/Debugx64Clang/factorio-run
alias fr12 /home/rai/dev/projects/wube/Factorio-1.1/bin/Releasex64Clang/factorio-run

source /usr/share/autojump/autojump.fish

# Enable jumping to fish prompts in scrollback in foot
function mark_prompt_start --on-event fish_prompt
    echo -en "\e]133;A\e\\"
end
