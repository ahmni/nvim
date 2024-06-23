vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.colorcolumn = "80"
vim.opt.smartindent = true
vim.opt.wrap = false

-- search settings
vim.opt.smartcase = true -- Note: to not ignore case, use /C after search
vim.opt.ignorecase = true

-- For EngineGoneRogue
local SetTabWidth = function(num)
	vim.opt.tabstop = num
	vim.opt.shiftwidth = num
	vim.opt.softtabstop = num
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp", "java" },
	callback = function() SetTabWidth(4) end,
})

-- undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.g.virtual_lsp_active = false
vim.diagnostic.config({
	virtual_text = false,
	underline = false,
})

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- remove tilde on end of buffer
vim.opt.fillchars = { eob = " " }
