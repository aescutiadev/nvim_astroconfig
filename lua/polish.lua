-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.g.python3_host_prog = vim.fn.expand "~/.venvs/nvim/bin/python"
vim.g.node_host_prog = "/usr/local/bin/npm"
