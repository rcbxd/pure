source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_prompt_ssh.fish
source $current_dirname/../functions/_pure_prompt_ssh_user.fish
source $current_dirname/../functions/_pure_prompt_ssh_separator.fish
source $current_dirname/../functions/_pure_prompt_ssh_host.fish
source $current_dirname/../functions/_pure_set_color.fish
source $current_dirname/../tools/versions-compare.fish


@test "_pure_prompt_ssh: hide 'user@hostname' when working locally" (
    set --erase SSH_CONNECTION

    _pure_prompt_ssh

) $status -eq $SUCCESS

if fish_version_at_least '3.0.0'
    @mesg (print_fish_version_at_least '3.0.0')
    @test "_pure_prompt_ssh: displays 'user@hostname' when on SSH connection (based on \$hostname variable)" (
        set --global pure_color_ssh_user_normal $EMPTY
        set --global pure_color_ssh_separator $EMPTY
        set --global pure_color_ssh_hostname $EMPTY
        set SSH_CONNECTION 127.0.0.1 56422 127.0.0.1 22
        function whoami; echo 'user'; end  # mock

        set prompt_ssh_host (_pure_prompt_ssh)
        string match --quiet --regex 'user@[\w]+' $prompt_ssh_host
        # $hostname is read-only, we cant determine it preceisely (e.g. is dynamic in docker container)
    ) $status -eq $SUCCESS
end
