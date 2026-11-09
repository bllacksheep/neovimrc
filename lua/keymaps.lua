vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent forward" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent backward" })
