
local ok, mod = pcall(require, 'nvim-treesitter.configs')
if ok then
  mod.setup {
    ensure_installed = "maintained",
    sync_install = true,
    incremental_selection = {
        enable = true,
        keymaps = {
            -- mappings for incremental selection (visual mappings)
            init_selection = "gnn", -- maps in normal mode to init the node/scope selection
            node_incremental = "grn", -- increment to the upper named parent
            scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
            node_decremental = "grm" -- decrement to the previous node
        }
    },
    indent = {
        enable = true
    },
    textobjects = {
        -- syntax-aware textobjects
        enable = true,
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["ae"] = "@block.outer",
            ["ie"] = "@block.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["is"] = "@statement.inner",
            ["as"] = "@statement.outer",
            ["ad"] = "@comment.outer",
            ["am"] = "@call.outer",
            ["im"] = "@call.inner"
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
              ["]a"] = "@parameter.inner"
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer"
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
              ["[a"] = "@parameter.inner"
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer"
            }
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer"
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>]"] = "@parameter.inner"
            },
            swap_previous = {
                ["<leader>["] = "@parameter.inner"
            }
        }
    }
  }
end                        
