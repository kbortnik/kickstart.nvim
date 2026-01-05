-- PHP specific settings for better indentation
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

-- Enable treesitter indent
vim.bo.indentexpr = 'nvim_treesitter#indent()'

-- Better indentation for HTML in PHP files
vim.bo.cindent = false
vim.bo.smartindent = true
vim.bo.autoindent = true

-- Set comment string for PHP
vim.bo.commentstring = '// %s'