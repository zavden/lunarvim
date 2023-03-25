lvim.log.level = "warn"
lvim.colorscheme = "tokyonight"
lvim.background = "dark"
lvim.builtin.treesitter.rainbow.enable = true
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["<M-m>"] = ":BufferLineMoveNext<CR>"
lvim.keys.normal_mode["<M-n>"] = ":BufferLineMovePrev<CR>"
lvim.builtin.indentlines.options.show_current_context = true

lvim.builtin.telescope.defaults.layout_config = {
  height = 0.9,
  width = 0.9,
  bottom_pane = {
    height = 25,
    preview_cutoff = 120,
  },
  center = {
    height = 0.4,
    preview_cutoff = 40,
    width = 0.5,
  },
  cursor = {
    preview_cutoff = 40,
  },
  horizontal = {
    preview_cutoff = 120,
    preview_width = 0.6,
  },
  vertical = {
    preview_cutoff = 40,
  },
  flex = {
    flip_columns = 150,
  },
}

for key, _ in pairs(lvim.builtin.telescope.pickers) do
  if key ~= "planets" then
    lvim.builtin.telescope.pickers[key].previewer = nil
    lvim.builtin.telescope.pickers[key].theme = nil
    lvim.builtin.telescope.pickers[key].layout_strategy = nil
  end
end

lvim.builtin.telescope.live_preview = true
lvim.builtin.telescope.pickers.git_files.previewer = nil
lvim.builtin.telescope.pickers.find_files.previewer = nil
lvim.builtin.telescope.pickers.buffers.previewer = nil

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}


lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

local opts = {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true
      }
    }
  }
} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("pyright", opts)
local lspconfig = require("lspconfig")

lspconfig.volar.setup{
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    extra_args = { "--print-with", "80" },
    filetypes = { "typescript", "typescriptreact", "javascript", "vue" },
  },
}

local cmp = require 'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require("tokyonight").setup({
  style = "night",
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true },
    variables = {},
    operators = { bold = true },
    booleans = { bold = true },
    sidebars = "dark",
    floats = "dark",
  },
  on_highlights = function(hl, c)
    hl.Type                 = { fg = c.blue1, bold = true }
    hl.Conditional          = { fg = c.magenta, bold = true }
    hl.Repeat               = { fg = c.magenta, bold = true }
    hl.Label                = { fg = c.red }
    hl.Constant             = { fg = c.orange, bold = true }
    hl.String               = { fg = c.green }
    hl.Character            = { fg = c.green }
    hl.Number               = { fg = c.orange }
    hl.Boolean              = { fg = c.orange }
    hl.Float                = { fg = c.orange }
    hl["@constructor"]      = { fg = c.blue1 }
    hl["@variable.builtin"] = { fg = c.red }
    hl.Include              = { fg = c.magenta, bold = true }
    hl.CursorLineNr         = { fg = c.blue, bold = true }
    hl.rainbowcol3          = { fg = c.cyan }
    hl.rainbowcol2          = { fg = c.purple }
    hl.rainbowcol1          = { fg = '#F4CA0D' }
    hl.rainbowcol4          = { fg = '#F4CA0D' }
    hl.rainbowcol5          = { fg = c.purple }
    hl.rainbowcol6          = { fg = c.cyan }
    hl.rainbowcol7          = { fg = '#F4CA0D' }
    hl.rainbowcol7 = { fg = c.purple }
    hl["@punctuation.bracket"] = { fg = c.magenta } -- For brackets and parens.

  end
})
-- Additional Plugins
lvim.plugins = {
  { "jose-elias-alvarez/typescript.nvim",
    config = function()
      local augroup = vim.api.nvim_create_augroup("TypescriptAutoImport", {})
      require("typescript").setup({
        server = {
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              command = "TypescriptAddMissingImports",
            })
          end
        },
      })
    end,
  },
  -- { "morhetz/gruvbox"},
  -- { "sainnhe/gruvbox-material" },
  -- { "ellisonleao/gruvbox.nvim" },
  {
    "aca/emmet-ls",
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', "vue" }
      })
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup {
          filetypes = { "*" },
          user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = true, -- "Name" codes like Blue or blue
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            AARRGGBB = true, -- 0xAARRGGBB hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes for `mode`: foreground, background,  virtualtext
            mode = "background", -- Set the display mode.
            -- Available methods are false / true / "normal" / "lsp" / "both"
            -- True is same as normal
            tailwind = false, -- Enable tailwind colors
            -- parsers can contain values used in |user_default_options|
            sass = { enable = true }, -- Enable sass colors
            virtualtext = "■",
            -- update color values even if buffer is not focused
            -- example use: cmp_menu, cmp_docs
            always_update = false
          },
          buftypes = {},
      }
    end
  },
  { "mrjones2014/nvim-ts-rainbow",
    config = function ()
      require('nvim-treesitter.configs').setup({
        rainbow = {
          enable = true,
          disable = { "jsx", "vue", "html" },
          extended_mode = true,
          max_file_lines = nil,
        },
      })
    end
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
      vim.g.rnvimr_edit_cmd = 'drop'
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = { "html", "xml", "vue", "jsx", "tsx", "javascript", "typescript" },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "tpope/vim-surround",
    setup = function()
      vim.o.timeoutlen = 500
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 90;
        height = 13;
        default_mappings = false;
        debug = false;
        opacity = nil;
        post_open_hook = nil
      }
    end
  },
  { "mg979/vim-visual-multi",
    config = function ()
      vim.cmd[[
      nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Cursor)
      nmap   <C-RightMouse>        <Plug>(VM-Mouse-Word)  
      nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)
      ]]
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  { "rbong/vim-flog" }
}

-- vim.cmd(":GitBlameDisabled")
vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
vim.cmd("nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>")
--
vim.opt.tabstop = 1
vim.opt.showtabline = 2
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 1
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true

vim.cmd("filetype indent on")
vim.cmd("filetype indent plugin on")

vim.cmd[[
  inoremap <c-F> <cr><esc><<<<ko<bs>
  inoremap <c-L> <cr><esc><<ko<bs><tab>
]]


vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.py" },
  command = "setlocal tabstop=2 shiftwidth=2"
})

lvim.builtin.which_key.mappings["j"] = {
  name = "Spectre",
  j = { "<cmd>lua require('spectre').open()<CR>", "Open spectre" },
  w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search current word" },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "Ranger",
  r = { ":RnvimrToggle<CR>", "Open ranger" },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
lvim.builtin.which_key.mappings["W"] = {
  name = "Refresh",
  W = { "<cmd>w<cr><cmd>e!<cr>", "Total refresh" },
}
lvim.builtin.which_key.mappings["Q"] = {
  name = "Pre exit",
  Q = { "<cmd>qa!<cr>", "Exit" },
}


lvim.builtin.treesitter.matchup.enable = true
vim.opt.sidescrolloff = 3
vim.opt.scrolloff = 3

lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 2000 }
  end,
  "Format",
}

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
    filetypes = { "html", "xml", "vue", "jsx", "tsx", "javascript", "typescript" },
  }
}

lvim.builtin.which_key.mappings["S"] = {
  "<cmd>:HopLine<CR>", "Hop"
}

-- require("nvim-autopairs").setup {}
