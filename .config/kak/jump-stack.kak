declare-option str my_jump_buffers \*(grep|find|callers|callees|goto|symbols|diagnostics|make)\b.*\*
declare-option str my_make_buffers \*(cargo|make)\*

map global normal <c-a-n> %{:jump-next -matching %opt{my_jump_buffers}<ret>} -docstring 'next location'
map global normal <c-a-p> %{:jump-previous -matching %opt{my_jump_buffers}<ret>} -docstring 'previous location'
map global normal <c-a-e> %{:my-push-buffer<ret>} -docstring 'push buffer'
map global normal <c-a-r> %{:my-jump-buffer-pop %opt{my_jump_buffers}<ret>} -docstring 'pop jump buffer'
map global user j %{:buffer -matching %opt{my_jump_buffers}<ret>} -docstring "latest jump buffer"

define-command -override my-push-buffer %{
	declare-option str my_push_buffer_safeguard nop
	evaluate-commands %sh{
		if printf %s "${kak_bufname}" | grep -q '^\*'; then {
			basename=$(printf %s "${kak_bufname}" | sed 's,\(-[0-9]*\)\?\*$,,')
			echo "rename-buffer $basename-|*"
		} else {
			echo  "
			%opt{my_push_buffer_safeguard}
			set-option local my_push_buffer_safeguard %{fail recursion}
			evaluate-commands -draft %{
				buffer -matching %opt{my_jump_buffers}
				my-push-buffer
			}
			"
		} fi
	}
}
define-command my-jump-buffer-pop -params 1 -docstring %{
	delete the given buffer.
	Activate the new last buffer in the client specified in the 'toolsclient'
	option. If the active client is different from 'toolsclient', jump to
	the current location.
} %{
	buffer -matching %arg{1}
	delete-buffer
	try %{
		evaluate-commands -save-regs b %{
			evaluate-commands -try-client %opt{toolsclient} %{
				buffer -matching %arg{1}
				set-register b %val{bufname}
			}
			evaluate-commands -try-client %opt{jumpclient} %{
				evaluate-commands %sh{
					if [ -n "${kak_opt_toolsclient}" ] &&
					[ "${kak_client}" != "${kak_opt_toolsclient}" ]; then
					echo buffer %reg{b}
					echo jump
					fi
				}
			}
			echo -markup {Information}{\}returned to buffer %reg{b}
		}
	} catch %{
		echo -markup {Information}no jump buffer remaining
	}
}
