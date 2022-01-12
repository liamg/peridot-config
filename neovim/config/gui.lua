
-- set theme
vim.g.tokyonight_style = "night"
vim.cmd[[set termguicolors]]
vim.cmd[[silent! colorscheme tokyonight]]


-- nice map function
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- search
map('n', '<leader>fn', ':Files<CR>', opts)
map('n', '<leader>fe', ':Rg<CR>', opts)

-- terminal
map('n', '<leader>j', ':terminal<CR>a', opts)
map('t', '<Esc>', '<C-\\><C-n>:q<CR>', opts)

-- save all
map('n', '<C-s>', ':wall<CR>', opts)
map('n', '<C-q>', ':qall<CR>', opts)

-- lualine (at bottom)
local ok, lualine = pcall(require, 'lualine')
if ok then
    lualine.setup {
        options = {
            theme = 'tokyonight'
        }
    }
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
map('n', '<leader>n', ':lua require("config.tree").toggle()<CR>', opts)

-- barbar tabs
-- Set barbar's options
vim.g.bufferline = {
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = true,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = false,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = false,

  -- Excludes buffers from the tabline
  --exclude_ft = {'javascript'},
  --exclude_name = {'package.json'},

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

-- set offset off barbar tabs if neovim is opened with barbar visible
local ok, view = pcall(require, 'nvim-tree.view')
if ok then
  local ok, state = pcall(require, 'bufferline.state')
  if ok then
    if view.win_open() then
      state.set_offset(vim.g.nvim_tree_width + 1, 'FileTree')
    end
  end
end

-- barbar bindings

-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Close all but current
map('n', '<A-z>', ':BufferCloseAllButCurrent<CR>', opts)
-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- close floating windows
map('n', '<C-e>', ':lua require("config.floats").close()<CR>', opts)

-- trigger code action
map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
