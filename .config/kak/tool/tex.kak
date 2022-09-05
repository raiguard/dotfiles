# Utilities for latex documents

map global insert <tab> "<a-;>:snippets-select-next-placeholders<ret>"

# define-command snippets-try %{
#     try %{
#         snippets-select-next-placeholders
#     } catch %{
#         execute-keys "i<tab>"
#     }
# }

set-option -add global snippets \
    Sum sum %{ snippets-insert "\sum_{$1}^{$2} ($3) $4" } \
    "Block math" bmath %{ snippets-insert "$$$$ $1 $$$$" } \
    Fraction // %{ snippets-insert "\frac{$1}{$2} $3" } \
    Limit lim %{ snippets-insert "\lim_{${1:n} \to ${2:\infty}} $3" }
