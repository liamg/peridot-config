
local ok, navigator = pcall(require, 'navigator')
if ok then
    require'navigator'.setup({
        debug = false, -- log output, set to true and log path: ~/.local/share/nvim/gh.log
        width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
        height = 0.3, -- max list window height, 0.3 by default
        transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it
        icons = {
            icons = true, -- set to false to use system default ( if you using a terminal does not have nerd/icon)
            -- Code action
            code_action_icon = '🔧', -- "",
            -- code lens
            code_lens_action_icon = '👓',
            -- Diagnostics
            diagnostic_head = '🐛',
            diagnostic_err = '⛔',
            diagnostic_warn = '⚠',
            diagnostic_info = [[ℹ]],
            diagnostic_hint = [[💡]],
        
            diagnostic_head_severity_1 = '☠',
            diagnostic_head_severity_2 = '⛔',
            diagnostic_head_severity_3 = '⚠',
            diagnostic_head_description = '📌',
            diagnostic_virtual_text = '📌',
            diagnostic_file = '🚑',
            -- Values
            value_changed = '📝',
            value_definition = '🐶🍡', -- it is easier to see than 🦕
            -- Treesitter
            match_kinds = {
              var = ' ', -- "👹", -- Vampaire
              method = 'ƒ ', --  "🍔", -- mac
              ['function'] = ' ', -- "🤣", -- Fun
              parameter = '  ', -- Pi
              associated = '🤝',
              namespace = '🚀',
              type = ' ',
              field = '🏈',
            },
            treesitter_defult = '🌲',   
        },
      })
end

local ok, go = pcall(require, 'go')
if ok then
    -- Setup the go plugin
    require('go').setup({
        goimport='gopls', -- goimport command, can be gopls[default] or goimport
        gofmt = 'gofumpt', --gofmt cmd,
        max_line_len = 120, -- max line length in goline format
        tag_transform = false, -- tag_transfer  check gomodifytags for details
        test_template = '', -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
        test_template_dir = '', -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
        comment_placeholder = '' ,  -- comment_placeholder your cool placeholder e.g. ﳑ       
        icons = {breakpoint = '', currentpos = ''},
        verbose = false,  -- output loginf in messages
        lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
                         -- false: do nothing
                         -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
                         --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
        lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
                             --      when lsp_cfg is true
                             -- if lsp_on_attach is a function: use this function as on_attach function for gopls
        lsp_codelens = true, -- set to false to disable codelens, true by default
        gopls_remote_auto = true, -- add -remote=auto to gopls
        gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
        fillstruct = 'gopls', -- can be nil (use fillstruct, slower) and gopls
        lsp_diag_hdlr = true, -- hook lsp diag handler
        dap_debug = true, -- set to false to disable dap
        textobjects = true, -- enable default text jobects through treesittter-text-objects
        test_runner = 'go', -- richgo, go test, richgo, dlv, ginkgo
        run_in_floaterm = true, -- set to true to run in float window.
        --float term recommand if you use richgo/ginkgo with terminal color
        dap_debug_keymap = true, -- set keymaps for debugger
        dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
        dap_debug_vt = true, -- set to true to enable dap virtual text
        build_tags = "tag1,tag2" -- set default build tags
      })

    -- Import on save
    vim.api.nvim_exec([[autocmd BufWritePre *.go :silent! lua require('go.format').goimport()]], false)

    -- misc keybindings
    vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>gt :GoAddTag<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>fs :GoFillStruct<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>fS :GoFillSwitch<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>ie :GoIfErr<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>fp :GoFixPlurals<CR>")
    
    -- debug bindings
    
    vim.cmd("autocmd FileType go nmap <Leader>dd :GoDebug<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>dT :GoDebug test<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>dr :GoDebug restart<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>dn :GoDebug nearest<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>ds :GoDebug stop<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>db :GoBreakToggle<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>dB :GoBreakCondition<CR>")

    -- test bindings
    vim.cmd("autocmd FileType go nmap <Leader>tt :GoTest<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>tf :GoTestFunc<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>tF :GoTestFile<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>tp :GoTestPkg<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>ta :GoAddTest<CR>")
    vim.cmd("autocmd FileType go nmap <Leader>tA :GoAddAllTest<CR>")
end
