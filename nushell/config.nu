use std/util "path add"
path add "~/.local/bin"

$env.config.show_banner = false
$env.config.edit_mode = "vi"

$env.config.buffer_editor = [hx helix nvim vim vi $env.EDITOR?] | each { which ^($in) | get command } | flatten | first
$env.VISUAL = $env.config.buffer_editor
$env.FCEDIT = $env.config.buffer_editor
def --wrapped e [...args] { ^$env.config.buffer_editor ...$args }
def --wrapped e. [...args] { ^$env.config.buffer_editor . ...$args }

$env.PROMPT_COMMAND_RIGHT = {||}
