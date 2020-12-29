source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_set_color.fish


@test "_pure_set_color: set using a named color" (
    set colorize (_pure_set_color "red")

    echo $colorize'foo'
) = (set_color red)'foo'

@test "_pure_set_color: empty value do not colorize" (
    set colorize (_pure_set_color $EMPTY)

    echo $colorize'foo'
) = 'foo'
