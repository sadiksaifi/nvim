-- Stay in visual mode after indenting
vim.keymap.set("x", "<", "<gv", { desc = "Shift left" })
vim.keymap.set("x", ">", ">gv", { desc = "Shift right" })
-- Paste over selection without yanking the replaced text
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yanking replaced text" })

-- Center buffer while navigating
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
vim.keymap.set("n", "{", "{zz", { desc = "Jump to previous paragraph and center" })
vim.keymap.set("n", "}", "}zz", { desc = "Jump to next paragraph and center" })
vim.keymap.set("n", "N", "Nzz", { desc = "Search previous and center" })
vim.keymap.set("n", "n", "nzz", { desc = "Search next and center" })
vim.keymap.set("n", "G", "Gzz", { desc = "Go to end of file and center" })
vim.keymap.set("n", "gd", "gdzz", { desc = "Go to definition and center" })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { desc = "Jump forward in jump list and center" })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { desc = "Jump backward in jump list and center" })
vim.keymap.set("n", "%", "%zz", { desc = "Jump to matching bracket and center" })
vim.keymap.set("n", "*", "*zz", { desc = "Search for word under cursor and center" })
vim.keymap.set("n", "#", "#zz", { desc = "Search backward for word under cursor and center" })

-- Copy current file path to clipboard
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path: " .. path)
end, { desc = "Copy current file path to clipboard" })

-- Harpoon keybinds --
vim.keymap.set("n", "<leader>ho", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "Toggle Harpoon quick menu" })

vim.keymap.set("n", "<leader>ha", function()
  require("harpoon.mark").add_file()
end, { desc = "Add current file to Harpoon" })

vim.keymap.set("n", "<leader>1", function()
  require("harpoon.ui").nav_file(1)
end, { desc = "Navigate to Harpoon file 1" })

vim.keymap.set("n", "<leader>2", function()
  require("harpoon.ui").nav_file(2)
end, { desc = "Navigate to Harpoon file 2" })

vim.keymap.set("n", "<leader>3", function()
  require("harpoon.ui").nav_file(3)
end, { desc = "Navigate to Harpoon file 3" })

vim.keymap.set("n", "<leader>4", function()
  require("harpoon.ui").nav_file(4)
end, { desc = "Navigate to Harpoon file 4" })

vim.keymap.set("n", "<leader>5", function()
  require("harpoon.ui").nav_file(5)
end, { desc = "Navigate to Harpoon file 5" })
