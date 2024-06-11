define-command delete-all-buffers -docstring "delete all buffers" %{
  evaluate-commands %sh{
  eval "set -- $kak_quoted_buflist"
  while [ $# -gt 0 ]; do
    firstchar=$(echo "$1" | cut -c 1)
    # Don't delete scratch buffers
    if [ "$firstchar" != "*" ]; then
      echo "try %{ delete-buffer '$1' } catch %{ echo -markup '{Error}Not all buffers were closed' }"
    fi
    shift
  done
  }
}
define-command delete-all-buffers-force -docstring "forcibly delete all buffers" %{
  evaluate-commands %sh{
  eval "set -- $kak_quoted_buflist"
  while [ $# -gt 0 ]; do
    echo "try %{ delete-buffer! '$1' } catch %{ echo -markup '{Error}Not all buffers were closed' }"
    shift
  done
  }
}
define-command write-delete-buffer -docstring "write current buffer then delete it." %{
  write
  delete-buffer
}
alias global dab delete-all-buffers
alias global dab! delete-all-buffers-force
alias global wdb write-delete-buffer
