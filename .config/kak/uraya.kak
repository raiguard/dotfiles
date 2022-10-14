# Color scheme
colorscheme one-darker-16
# Mark.kak faces
set-face global MarkedPrimaryCursor PrimaryCursor
set-face global MarkedPrimarySelection black,magenta
set-face global MarkedSecondaryCursor MarkedPrimaryCursor
set-face global MarkedSecondarySelection MarkedPrimarySelection
# kak-live-grep faces
set-face global LiveGrepMatch +u
# Trailing whitespace
add-highlighter global/trailing-whitespaces regex "(\h+)$" 1:,red+B
# FandT faces
hook global ModeChange push:.*:user.fandt %{
    set-face window PrimarySelection black,yellow
    set-face window SecondarySelection black,yellow
}
hook global ModeChange pop:user.fandt:.* %{
    unset-face window PrimarySelection
    unset-face window SecondarySelection
}
