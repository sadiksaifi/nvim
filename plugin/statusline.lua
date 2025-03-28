-- local fn = vim.fn
-- local api = vim.api
--
-- local M = {}
--
-- -- possible values are 'arrow' | 'rounded' | 'blank'
-- local active_sep = "blank"
--
-- -- change them if you want to different separatora
-- M.separators = {
--   arrow = { "", "" },
--   rounded = { "", "" },
--   blank = { "", "" },
-- }
--
-- -- highlight groups
-- M.colors = {
--   active = "%#StatusLine#",
--   inactive = "%#StatusLineNC#",
--   mode = "%#StatusLineMode#",
--   mode_alt = "%#StatusLineModeAlt#",
--   filetype = "%#StatusLineFT#",
--   filetype_alt = "%#StatusLineFTAlt#",
--   line_col = "%#StatusLineLCol#",
--   line_col_alt = "%#StatusLineLColAlt#",
--   lsp = "%#StatusLineLSP#",
--   filename = "%#StatusLineFileName#",
-- }
--
-- M.modes = setmetatable({
--   ["n"] = "Normal",
--   "N",
--   ["no"] = "N·Pending",
--   "N·P",
--   ["v"] = "Visual",
--   "V",
--   ["V"] = "V·Line",
--   "V·L",
--   [""] = "V·Block",
--   "V·B", -- this is not ^V, but it's , they're different
--   ["s"] = "Select",
--   "S",
--   ["S"] = "S·Line",
--   "S·L",
--   [""] = "S·Block",
--   "S·B", -- same with this one, it's not ^S but it's 
--   ["i"] = "Insert",
--   "I",
--   ["ic"] = "Insert",
--   "I",
--   ["R"] = "Replace",
--   "R",
--   ["Rv"] = "V·Replace",
--   "V·R",
--   ["c"] = "Command",
--   "C",
--   ["cv"] = "Vim·Ex ",
--   "V·E",
--   ["ce"] = "Ex ",
--   "E",
--   ["r"] = "Prompt ",
--   "P",
--   ["rm"] = "More ",
--   "M",
--   ["r?"] = "Confirm ",
--   "C",
--   ["!"] = "Shell ",
--   "S",
--   ["t"] = "Terminal ",
--   "T",
-- }, {
--   __index = function()
--     return { "Unknown", "U" } -- handle edge cases
--   end,
-- })
--
-- M.get_current_mode = function(self)
--   local current_mode = api.nvim_get_mode().mode
--   return string.format(" %s ", self.modes[current_mode]):upper()
-- end
--
-- M.get_filepath = function()
--   local filepath = fn.fnamemodify(fn.expand "%", ":.:h")
--   if filepath == "" or filepath == "." then
--     return " "
--   end
--
--   return string.format(" %%<%s/", filepath)
-- end
--
-- M.get_filename = function()
--   local filename = fn.expand "%:t"
--   if filename == "" then
--     return ""
--   end
--   return filename
-- end
--
-- M.get_filetype = function()
--   -- local file_name, file_ext = fn.expand "%:t", fn.expand "%:e"
--   -- local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })
--   local filetype = vim.bo.filetype
--
--   if filetype == "" then
--     return " No FT "
--   end
--   -- return string.format(" %s %s ", icon, filetype):lower()
--   return string.format(" %s ", filetype):lower()
-- end
--
-- M.get_line_col = function()
--   return " %l:%c "
-- end
--
-- M.lsp_progress = function()
--   -- local lsp = vim.lsp.util.get_progress_messages()[1]
--   local lsp = vim.lsp.status()
--
--   if lsp then
--     return lsp
--     --   local name = lsp.name or ""
--     --   local msg = lsp.message or ""
--     --   local percentage = lsp.percentage or 0
--     --   local title = lsp.title or ""
--     --   return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
--   end
--
--   return ""
-- end
--
-- M.set_active = function(self)
--   local colors = self.colors
--
--   local mode = colors.mode .. self:get_current_mode()
--   local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
--
--   local filename = string.format(
--     "%s%s%s%s%s",
--     colors.inactive,
--     self:get_filepath(),
--     colors.filename,
--     self:get_filename(),
--     colors.inactive
--   )
--
--   local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
--   local filetype = colors.filetype .. self:get_filetype()
--   local line_col = colors.line_col .. self:get_line_col()
--   local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]
--   local lsp = colors.lsp .. self:lsp_progress()
--
--   return table.concat {
--     colors.active,
--     mode,
--     mode_alt,
--     filename,
--     "%=",
--     lsp,
--     filetype_alt,
--     filetype,
--     line_col,
--     line_col_alt,
--   }
-- end
--
-- M.set_inactive = function(self)
--   return self.colors.inactive .. "%= %F %="
-- end
--
-- M.set_explorer = function(self)
--   local title = self.colors.mode .. "   "
--   local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]
--
--   return self.colors.active .. title .. title_alt
-- end
--
-- Statusline = setmetatable(M, {
--   __call = function(self, mode)
--     return self["set_" .. mode](self)
--   end,
-- })
--
-- -- set statusline
-- -- TODO(elianiva): replace this once we can define autocmd using lua
-- vim.cmd [[
--   augroup Statusline
--   au!
--   au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
--   au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
--   au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
--   augroup END
-- ]]
--
-- vim.opt.showmode = false
