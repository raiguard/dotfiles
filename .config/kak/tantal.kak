# # Color scheme
# colorscheme one-darker
# # Mark.kak faces
# set-face global MarkedPrimaryCursor "default,rgba:%opt{magenta}%opt{cursoralpha}"
# set-face global MarkedPrimarySelection "default,rgba:%opt{magenta}%opt{selectionalpha}"
# set-face global MarkedSecondaryCursor "default,rgba:%opt{magenta}%opt{cursoralpha}"
# set-face global MarkedSecondarySelection "default,rgba:%opt{magenta}%opt{selectionalpha}"
# # kak-live-grep faces
# set-face global LiveGrepMatch ",,rgb:%opt{darkorange}+u"
# # Trailing whitespace
# add-highlighter global/trailing-whitespaces regex "(\h+)$" "1:default,rgba:%opt{darkred}%opt{selectionalpha}"
# # FandT faces
# hook global ModeChange push:.*:user.fandt %{
#     set-face window PrimarySelection ",rgba:%opt{lightorange}%opt{selectionalpha}"
#     set-face window PrimaryCursor ",rgba:%opt{lightorange}%opt{cursoralpha}"
#     set-face window SecondarySelection ",rgba:%opt{darkorange}%opt{selectionalpha}"
#     set-face window SecondaryCursor ",rgba:%opt{darkorange}%opt{cursoralpha}"
# }
# hook global ModeChange pop:user.fandt:.* %{
#     unset-face window PrimarySelection
#     unset-face window PrimaryCursor
#     unset-face window SecondarySelection
#     unset-face window SecondaryCursor
# }
