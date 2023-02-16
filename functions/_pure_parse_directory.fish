function prompt_pwd
  set -q argv[1]
  and switch $argv[1]
    case -h --help
      __fish_print_help prompt_pwd
      return 0
  end

  set -q fish_prompt_pwd_dir_length
  or set -l fish_prompt_pwd_dir_length 1
  set ttmp $PWD
  set ttmp (string replace -r '^'$HOME'($|/)' '~$1' $PWD)
  set -l tmp (basename $ttmp)

  if [ $fish_prompt_pwd_dir_length -eq 0 ];
    echo $tmp
  else
    string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' $tmp
  end
end

function _pure_parse_directory \
    --description "Replace '$HOME' with '~'" \
    --argument-names max_path_length

    set folder (prompt_pwd)

    echo $folder
end
