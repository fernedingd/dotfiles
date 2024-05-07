-- [nfnl] Compiled from fnl/config/keys.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g["mapleader"] = " "
vim.g["maplocalleader"] = " "
local function map(modes, key, command, _3fdesc)
  return vim.keymap.set(modes, key, command, {desc = _3fdesc})
end
local function lmap(modes, key, command, _3fdesc)
  return map(modes, ("<leader>" .. key), command, _3fdesc)
end
local function cmd(command)
  return ("<cmd>" .. command .. "<cr>")
end
map({"i", "v"}, "jk", "<Esc>", "Back to normal mode")
local lspbuf = vim.lsp.buf
lmap("n", "jd", lspbuf.definition, "jump to definition")
lmap("n", "ji", lspbuf.implementation, "jump to implementation")
lmap("n", "jc", lspbuf.incoming_calls, "jump to incoming calls")
lmap("n", "jr", lspbuf.references, "jump to references")
map({"i", "n"}, "<C-i>", lspbuf.hover, "show hover information")
map({"i", "n"}, "<C-a>", lspbuf.code_action, "show code actions")
lmap("n", "rn", lspbuf.rename, "rename")
lmap("n", "ff", lspbuf.format, "format file")
lmap("v", "ff", lspbuf.format, "format range")
lmap("n", "ts", cmd("NvimTreeFocus"), "focus file tree")
lmap("n", "th", cmd("NvimTreeClose"), "hide tree")
lmap("n", "o", "o<Esc>", "below")
lmap("n", "O", "O<Esc>", "above")
lmap("n", "tf", cmd(":Telescope find_files"), "telescope find_files")
lmap("n", "tg", cmd(":Telescope live_grep"), "telescope live_grep")
map({"i", "n"}, "<C-h><C-a>", cmd("HarpoonAppend"), "add buffer to harpoon")
map({"i", "n"}, "<C-h><C-r>", cmd("HarpoonRemove"), "remove buffer from harpoon")
map({"i", "n"}, "<C-h><C-s>", cmd("HarpoonShow"), "show harpoon list")
map({"i", "n"}, "<C-k>", cmd("HarpoonPrev"), "jump to previous harpooned buffer")
map({"i", "n"}, "<C-j>", cmd("HarpoonNext"), "jump to next harpooned buffer")
lmap("n", "1", cmd("HarpoonSwitch 1"), "jump to harpoon buffer 1")
lmap("n", "2", cmd("HarpoonSwitch 2"), "jump to harpoon buffer 2")
lmap("n", "3", cmd("HarpoonSwitch 3"), "jump to harpoon buffer 3")
lmap("n", "4", cmd("HarpoonSwitch 4"), "jump to harpoon buffer 4")
lmap("n", "5", cmd("HarpoonSwitch 5"), "jump to harpoon buffer 5")
lmap("n", "6", cmd("HarpoonSwitch 6"), "jump to harpoon buffer 6")
lmap("n", "7", cmd("HarpoonSwitch 7"), "jump to harpoon buffer 7")
lmap("n", "8", cmd("HarpoonSwitch 8"), "jump to harpoon buffer 8")
lmap("n", "9", cmd("HarpoonSwitch 9"), "jump to harpoon buffer 9")
lmap("n", "h", cmd("bprev"), "go to previous buffer")
lmap("n", "l", cmd("bnext"), "go to next buffer")
map("n", "<S-Up>", cmd(":res -1"), "resize window")
map("n", "<S-Down>", cmd(":res +1"), "resize window")
map("n", "<S-Left>", cmd(":vert res +1"), "resize window")
map("n", "<S-Right>", cmd(":vert res -1"), "resize window")
lmap("n", "dn", "]c", "next diff")
lmap("n", "dp", "[c", "prev diff")
lmap("n", "<leader>dg", cmd(":diffget"), "use other change (two way diff)")
lmap("n", "<leader>dl", cmd(":diffget local"), "use local change")
lmap("n", "<leader>dr", cmd(":diffget remote"), "use change from remote")
return map({"i", "n"}, "<C-g><C-n>", cmd("GlobalNote"), "open/close global notes")
