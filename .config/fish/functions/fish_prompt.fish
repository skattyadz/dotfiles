# For profiling the prompt
# fish --profile prompt.prof -ic 'fish_prompt; exit'; sort -nk 2 prompt.prof

function prompt_pwd2 --description "Tidier pwd"
  set -l home_dir (string match -r "$HOME(/.*|\$)" "$PWD")
  if set -q home_dir[2]
    echo "~$home_dir[2]"
  end
end

function git_branch --description "Name of current git branch"
  set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
  test -n $branch; and echo ' '$branch' '
end

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  if not test $last_status -eq -0
    echo ❌
  end

  echo # newline

  set_color $BASE_02
  echo -n (prompt_pwd2)

  set_color $BASE_03
  echo -n (git_branch)

  echo # newline
  echo -n (~/.config/fish/random_emoji.sh)'  '
  set_color $normal
end
