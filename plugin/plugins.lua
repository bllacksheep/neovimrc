vim.pack.add {
  'https://github.com/folke/flash.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/folke/noice.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

require('flash').setup {
  modes = {
    char = {
      enabled = false,
    },
  },
}

vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
vim.keymap.set({ 'o' }, 'r', function() require('flash').remote() end, { desc = 'Remote Flash' })
vim.keymap.set({ 'x', 'o' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter Search' })
vim.keymap.set({ 'c' }, '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })

require('oil').setup {
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = false,
  view_options = {
    show_hidden = true,
    nauural_order = true,
    -- is_always_hidden = function(name, _)
    --     return name == '..' or name == '.git'
    -- end,
  },
  win_options = {
    wrap = true,
  },
}

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

require('snacks').setup {
  gh = { enabled = true },
  picker = { enabled = true },
  zen = { enabled = true },
  notifier = { enabled = true },
  scratch = { enabled = true },
}

vim.keymap.set({ 'n' }, '<leader>gi', function() Snacks.picker.gh_issue() end, { desc = 'GitHub Issues (open)' })
vim.keymap.set({ 'n' }, '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, { desc = 'GitHub Issues (all)' })
vim.keymap.set({ 'n' }, '<leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub Pull Requests (open)' })
vim.keymap.set({ 'n' }, '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, { desc = 'GitHub Pull Requests (all)' })
vim.keymap.set({ 'n' }, '<leader>*', function() Snacks.zen() end, { desc = 'Focus' })
vim.keymap.set({ 'n' }, '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })

require('noice').setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}

vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(vim.lsp.status(), 'info', {
      id = 'lsp_progress',
      title = 'LSP Progress',
      opts = function(notif) notif.icon = ev.data.params.value.kind == 'end' and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1] end,
    })
  end,
})

vim.keymap.set({ 'n' }, '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
vim.keymap.set({ 'n' }, '<leader>S', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
