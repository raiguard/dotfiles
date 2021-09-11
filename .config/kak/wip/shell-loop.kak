decl str-list my_list "foo bar" "lorem"

def test %sh{
    eval set -- "$kak_quoted_opt_my_list"
    while [ $# -gt 0 ]; do
    	echo "echo -debug $1"
        shift
    done
}

