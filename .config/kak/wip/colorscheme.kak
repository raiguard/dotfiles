decl -docstring "A list of directories for the `colorscheme` command to search through" \
    str-list colorscheme_sources "%val{runtime}/colors" "%val{config}/colors"

def -override -params 1 -docstring "colorscheme <name>: enable named colorscheme" \
    -shell-script-candidates %{
    eval set -- "$kak_quoted_opt_colorscheme_sources"
    find -L "$@" -type f -name '*\.kak' \
        | while read -r filename; do
            basename="${filename##*/}"
            printf %s\\n "${basename%.*}"
        done | sort -u
  } \
  colorscheme %{ evaluate-commands %sh{
    find_colorscheme() {
        find -L "${1}" -type f -name "${2}".kak | head -n 1
    }

    scheme_name=$1
    filename=""

    eval set -- "$kak_quoted_opt_colorscheme_sources"
    for source; do
        if [ -d "${source}" ]; then
            filename=$(find_colorscheme "${source}" "${scheme_name}" || ${filename})
        fi
        shift
    done

    if [ -n "${filename}" ]; then
        printf 'source %%{%s}' "${filename}"
    else
        echo "fail 'No such colorscheme ${scheme_name}.kak'"
    fi
}}
