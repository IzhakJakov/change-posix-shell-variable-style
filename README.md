## Overview
This plugin adds the user commands `:EmbracePosixShellVariables` and `:UnbracePosixShellVariables`
to Neovim.  These commands changes all the (posix compliant) shell variables from embraced style
to unbraced styled and vice versa.  You will need to confirm the change.

If configured with `style_toggle_keybinding`, this plugin will assign keybinding to the function
`togglePosixShellVariableStyle()`.   This function will toggle between the embraced (e.g. `$var`)
and the unbraced (e.g. `${var}`) styles.

## Installation

Use `'IzhakJakov/change-posix-shell-variable-style'` with your package manager.

## Configuration

By default `style_toggle_keybinding = ''` this means that the `togglePosixShellVariableStyle()`
function will not be initialized and no keybinding will be assigned to it.  In order to change
this, assign a keybinding value to `style_toggle_keybinding`, in the following example:

**Custom configuration with their default values**:
```lua
require('change-posix-shell-variable-style').setup({
	style_toggle_keybinding = '' -- change '' to your preferred keybinding (e.g. '<leader>v')
})
```

## Usage

Just execute the command you want and confirm the change for each variable in the buffer.
Or use your preferred keybinding toggle the style for the variable under the cursor.
