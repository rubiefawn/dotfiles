$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.buffer_editor = (which ^hx | append (which ^helix) | get 0.command)
def hx [] { ^$env.config.buffer_editor }
