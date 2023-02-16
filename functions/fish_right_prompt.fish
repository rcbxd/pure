function fish_right_prompt

    if set --query pure_show_system_time_pos; and test "$pure_show_system_time_pos" = 'right'
      set --local system_time (_pure_prompt_system_time)
      echo "$system_time"
    end

end
