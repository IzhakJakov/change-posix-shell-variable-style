local M = {}

function M.setup(custom)
	local defaults = {
		style_toggle_keybinding = '',
	}
	M.config = vim.tbl_extend('keep', custom, defaults)

	vim.api.nvim_create_user_command('EmbracePosixShellVariables', ':%s%\\$\\([_[:alpha:]][_[:alnum:]]*\\|[[:digit:]][[:digit:]]*\\)%${\\1}%gc', {})
	vim.api.nvim_create_user_command('UnbracePosixShellVariables', ':%s%\\${\\([_[:alpha:]][_[:alnum:]]*\\|[[:digit:]][[:digit:]]*\\)}%$\\1%gc', {})

	if M.config.style_toggle_keybinding ~= '' then
		-- Change a variable from embraced to unbraced and vice versa
		local function togglePosixShellVariableStyle()
			local bufnr = vim.api.nvim_get_current_buf()
			local initPoint = vim.api.nvim_win_get_cursor(0)
			local currentLine = vim.api.nvim_buf_get_lines(bufnr, initPoint[1] - 1, initPoint[1], false)[1]

			vim.cmd('normal! he')
			local finIndex = vim.api.nvim_win_get_cursor(0)[2]+2
			local char = string.sub(currentLine, finIndex, finIndex)
			if char == '}' then
				vim.cmd('normal! lb')
				local begIndex = vim.api.nvim_win_get_cursor(0)[2]
				char = string.sub(currentLine, begIndex-1, begIndex)
				if char == '${' then  -- embraced e.g. ${var}
					vim.cmd('normal! Xhelx')
					initPoint[2] = initPoint[2]-1
				end
			else
				vim.cmd('normal! l')
				vim.cmd('normal! b')
				local begIndex = vim.api.nvim_win_get_cursor(0)[2]
				char = string.sub(currentLine, begIndex, begIndex)
				if char == '$' then  -- unbraced e.g. $var
					vim.cmd('normal! lbi{')
					vim.cmd('normal! ea}')
					initPoint[2] = initPoint[2]+1
				end
			end

			vim.api.nvim_win_set_cursor(0, initPoint)
		end

		vim.keymap.set('n', M.config.style_toggle_keybinding, togglePosixShellVariableStyle)
	end
end

return M
