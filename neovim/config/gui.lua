
-- set theme
vim.cmd[[set termguicolors]]
local ok, theme = pcall(require, 'github-theme')
if ok then
    theme.setup({
      theme_style = "dark",
      function_style = "italic",
      keyword_style = "italic",
      variable_style = "italic",
      msg_area_style = "NONE",
      sidebars = {"terminal", "packer"},
      colors = { bg_search = "#bb4400" },
    })
end

-- nice map function
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- search
map('n', '<leader>fn', ':Files<CR>', opts)
map('n', '<leader>fe', ':Rg<CR>', opts)
map('n', '<leader>b', ':Buffers<CR>', opts)

-- terminal
map('n', '<leader>j', ':terminal<CR>a', opts)
map('t', '<Esc>', '<C-\\><C-n>:q<CR>', opts)

-- save all
map('n', '<C-s>', ':wall<CR>', opts)
map('n', '<C-q>', ':qall<CR>', opts)

-- lualine (at bottom)
local ok, lualine = pcall(require, 'lualine')
if ok then
    lualine.setup({
        options = {
            theme = "auto"
        }
    })
end

-- git magic
local ok, gitsigns = pcall(require, 'gitsigns')
if ok then
    gitsigns.setup {
      signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      keymaps = {
        -- Default keymap options
        noremap = true,
    
        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"},
    
        ['n <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
        ['v <leader>hs'] = ':Gitsigns stage_hunk<CR>',
        ['n <leader>hu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
        ['n <leader>hr'] = '<cmd>Gitsigns reset_hunk<CR>',
        ['v <leader>hr'] = ':Gitsigns reset_hunk<CR>',
        ['n <leader>hR'] = '<cmd>Gitsigns reset_buffer<CR>',
        ['n <leader>hp'] = '<cmd>Gitsigns preview_hunk<CR>',
        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
        ['n <leader>hS'] = '<cmd>Gitsigns stage_buffer<CR>',
        ['n <leader>hU'] = '<cmd>Gitsigns reset_buffer_index<CR>',
    
        -- Text objects
        ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
        ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
      },
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter_opts = {
        relative_time = false
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm = {
        enable = false
      },
    }
end

-- tree
vim.g.nvim_tree_icons = {
     default = '',
     symlink = '',
     git = {
       unstaged = "",
       staged = "✓",
       unmerged = "",
       renamed = "➜",
       untracked = "",
       deleted = "",
       ignored = ""
      },
     folder = {
       arrow_open = "",
       arrow_closed = "",
       default = "",
       open = "",
       empty = "",
       empty_open = "",
       symlink = "",
       symlink_open = ""
      }
}
vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
}

vim.g.nvim_tree_width = 30
local ok, tree = pcall(require, 'nvim-tree')
if ok then
    require'nvim-tree'.setup {
      disable_netrw       = true,
      hijack_netrw        = true,
      open_on_setup       = false,
      ignore_ft_on_setup  = {},
      auto_close          = false,
      open_on_tab         = false,
      hijack_cursor       = false,
      update_cwd          = false,
      update_to_buf_dir   = {
        enable = true,
        auto_open = true,
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        }
      },
      update_focused_file = {
        enable      = true,
        update_cwd  = false,
        ignore_list = {}
      },
      system_open = {
        cmd  = nil,
        args = {}
      },
      filters = {
        dotfiles = false,
        custom = {}
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
      view = {
        width = vim.g.nvim_tree_width,
        height = 30,
        hide_root_folder = false,
        side = 'left',
        auto_resize = true,
        mappings = {
          custom_only = false,
          list = {}
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes"
      },
      trash = {
        cmd = "trash",
        require_confirm = true
      }  
    }
end


-- toggle tree
map('n', '<leader>n', ':NvimTreeToggle<CR>', opts)

-- close floating windows
map('n', '<C-e>', ':lua require("config.floats").close()<CR>', opts)

-- trigger code action
map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
