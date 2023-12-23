function nothing
    set --universal fish_color_autosuggestion 363736 # ayu:common.ui        autosuggestions
    set --universal fish_color_command        81cabe # ayu:syntax.tag       commands
    set --universal fish_color_comment        ffe6ff # ayu:syntax.comment   code comments
    set --universal fish_color_cwd            c5d05d # ayu:syntax.entity    current working directory in the default prompt
    set --universal fish_color_end            ed9e56 # ayu:syntax.operator  process separators like ';' and '&'
    set --universal fish_color_error          df6464 # ayu:syntax.error     highlight potential errors
    set --universal fish_color_escape         81cabe # ayu:syntax.regexp    highlight character escapes like '\n' and '\x70'
    set --universal fish_color_match          ed9e56 # ayu:syntax.markup    highlight matching parenthesis
    set --universal fish_color_normal         363736 # ayu:common.fg        default color
    set --universal fish_color_operator       ed9e56 # ayu:syntax.accent    parameter expansion operators like '*' and '~'
    set --universal fish_color_param          edcf58 # ayu:common.fg        regular command parameters
    set --universal fish_color_quote          c5d05d # ayu:syntax.string    quoted blocks of text
    set --universal fish_color_redirection    edcf58 # ayu:syntax.constant  IO redirections
    set --universal fish_color_search_match   --background ed9e56 # ayu:syntax.accent    highlight history search matches and the selected pager item (must be a background)
    set --universal fish_color_selection      ed9e56 # ayu:syntax.accent    when selecting text (in vi visual mode)

    # color for fish default prompts item
    set --universal fish_color_cancel         0f0f0f # ayu:common.bg        the '^C' indicator on a canceled command
    set --universal fish_color_host           eeefef # ayu:syntax.constant  current host system in some of fish default prompts
    set --universal fish_color_host_remote    81cabe # ayu:syntax.constant  current host system in some of fish default prompts, if fish is running remotely (via ssh or similar)
    set --universal fish_color_user           CC2850 # ayu:syntax.keyword   current username in some of fish default prompts
end