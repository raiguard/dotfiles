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

# Color scheme
colorscheme one-darker-16
# Mark.kak faces
set-face global MarkedPrimaryCursor black,magenta+f
set-face global MarkedPrimarySelection black,magenta+f
set-face global MarkedSecondaryCursor MarkedPrimaryCursor
set-face global MarkedSecondarySelection MarkedPrimarySelection
# kak-live-grep faces
set-face global LiveGrepMatch +u
# FandT faces
hook global ModeChange push:.*:user.fandt %{
    set-face window PrimarySelection black,yellow
    set-face window SecondarySelection black,yellow
}
hook global ModeChange pop:user.fandt:.* %{
    unset-face window PrimarySelection
    unset-face window SecondarySelection
}
