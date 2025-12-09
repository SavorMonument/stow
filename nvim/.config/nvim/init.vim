set runtimepath^=~/.nvim runtimepath+=~/.nvim/after
let &packpath = &runtimepath

" set clipboard=unnamedplus
set nocompatible
filetype plugin on
syntax on

set nu
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=120
set autoindent
set fileformat=unix
set guicursor=i:block
set noswapfile
set cc=100

set termguicolors
set mouse=a

" Aliases
command! Wq wq
command! WQ wq
command! Wqa wqa
command! WQa wqa
command! WQA wqa
command! Q q
command! Qa qa
command! W w

" Splits
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'sbdchd/neoformat'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim', { 'commit': '171d4d5a1560ccb556e94aa6df7e969068384049' }

" autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Copilot
Plug 'github/copilot.vim'
" Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }

" Codeium
" Plug 'Exafunction/codeium.vim'

Plug 'jeetsukumaran/vim-pythonsense'
Plug 'vim-python/python-syntax'
" Plug 'integralist/vim-mypy'

Plug 'ap/vim-css-color'
Plug 'uiiaoo/java-syntax.vim'

" Theme
Plug 'vv9k/bogster'
Plug 'charlespascoe/vim-go-syntax'

" Snippets
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'
Plug 'honza/vim-snippets'
call plug#end()

" lua require('init')
"

lua <<EOF

--
-- For indent-blankline
--
local highlight = {
    "IndentGray",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function() vim.api.nvim_set_hl(0, "IndentGray", { fg = "#252f3b" }) end)


require("ibl").setup { indent = { highlight = highlight } }

-- require("ibl").setup { }

--
-- For indent-blankline
--

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = false,
  },

})

EOF

nnoremap <space>t :NvimTreeFindFileToggle<CR>

" ===================
" Bogster theme
" ===================

colorscheme bogster
hi Normal guibg=NONE ctermbg=NONE
highlight ColorColumn guibg=#263640

let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

" Prevent default python indent to 4 spaces
let g:python_recommended_style=0
let g:rust_recommended_style=0

" ===================
" nvim-cmp
" ===================

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup {
    preselect = cmp.PreselectMode.None
  }

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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
      { name = 'snippy' }, -- For snippy users.
      { name = 'path' }, -- For snippy users.
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

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
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

  -- Setup lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- local servers = {'rust_analyzer', 'gopls', 'clangd', 'jedi_language_server', 'jdtls'}
  -- for _, lsp in ipairs(servers) do
    -- require('lspconfig')[lsp].setup {
      -- capabilities = capabilities
    -- }
  -- end

-- TAB completion

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local snippy = require("snippy")

  local cmp = require("cmp")

  cmp.setup({

    -- ... Your other configuration ...

    mapping = {

      -- ... Your other mappings ...

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif snippy.can_expand_or_advance() then
          snippy.expand_or_advance()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif snippy.can_jump(-1) then
          snippy.previous()
        else
          fallback()
        end
      end, { "i", "s" }),

      -- ... Your other mappings ...
    },

    -- ... Your other configuration ...
  })
EOF

" ===================
" vim-commentary
" ===================

map \\ gcc
vmap \\ gc

" ===================
" Neofromat
" ===================

let g:neoformat_c_clangformat = {
              \ 'exe': 'clang-format',
              \ 'args': ['-assume-filename=.c', '-style="{IndentWidth: 2, ColumnLimit: 100, AllowShortFunctionsOnASingleLine: false}"'],
              \ 'stdin': 1,
              \ }

let g:neoformat_cpp_clangformat = {
              \ 'exe': 'clang-format',
              \ 'args': ['-style="{IndentWidth: 2, ColumnLimit: 100, AllowShortFunctionsOnASingleLine: false}"'],
              \ 'stdin': 1,
              \ }

let g:neoformat_rust_rustfmt = {
              \ 'exe': "rustfmt",
              \ 'args': ["--edition", "2024", "--config", "tab_spaces=2"],
              \ 'stdin': 1,
              \ }

let g:neoformat_java_astyle = {
            \ 'exe': 'astyle',
            \ 'args': ['--mode=java', '-s2', '2>', '/tmp/neoformat/stderr.log'],
            \ 'stdin': 1,
            \ }

let g:neoformat_jsp_custom = {
            \ 'exe': '/home/zzz1/xml-format/fxml.py',
            \ 'stdin': 0,
            \ 'valid_exit_codes': [0],
            \ }

let g:neoformat_html_custom = {
            \ 'exe': '/usr/local/bin/html-beautify',
            \ 'args': ['--indent-size=2', '-w', '100', '--wrap-attributes', 'force-aligned'],
            \ 'stdin': 0,
            \ 'valid_exit_codes': [0, 1],
            \ }

let g:neoformat_css_custom = {
            \ 'exe': '/usr/local/bin/css-beautify',
            \ 'args': ['--indent-size=2'],
            \ 'stdin': 1,
            \ 'valid_exit_codes': [0, 1],
            \ }

let g:neoformat_python_yapf = {
            \ 'exe': 'yapf',
            \ 'args': ["--style='{based_on_style: google, indent_width: 2, column_limit: 100, SPLIT_ALL_COMMA_SEPARATED_VALUES: 1}'", '-'],
            \ }

let g:neoformat_python_autopep8 = {
            \ 'exe': 'autopep8',
            \ 'args': ['--indent-size=2', '--aggressive', "--max-line-length=100"],
            \ }

let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_enabled_python = ['autopep8']

" let g:neoformat_html_custom = {
"             \ 'exe': '/usr/local/bin/prettier',
"             \ 'args': ['--print-width', '100', '--bracket-same-line', 'true', '--parser', 'html', '%:p'],
"             \ 'stdin': 1,
"             \ }

lua <<EOF

vim.filetype.add({
  -- ...
  -- Some more configurations
  -- ...
  extension = {
    tmpl = "html",
  }
  -- pattern = {
    -- [".?.tmpl"] = "html",
  -- },
})
EOF

let g:neoformat_enabled_jsp = ['custom']
let g:neoformat_enabled_html = ['custom']
let g:neoformat_enabled_css = ['custom']
let g:neoformat_enabled_java = ['astyle']

noremap <space>w :Neoformat<CR>

" ===================
" Telescope
" ===================

nnoremap <space>f :Telescope find_files<CR>
nnoremap <space>g :Telescope live_grep<CR>
nnoremap <space>d :Telescope diagnostics<CR>
nnoremap <space>s :Telescope lsp_dynamic_workspace_symbols<CR>

nnoremap <space>a :lua vim.lsp.buf.code_action()<CR>

" ===================
" Lsp
" ===================

" lspconfig turn off top split preview
set completeopt-=preview

lua <<EOF
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
 vim.lsp.handlers.signature_help, {

 }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- stops gutter from moving around
  -- buf_set_option('signcolumn', 'yes:1')
  vim.o.signcolumn = "yes:1"
  -- Supertab triggger
  -- vim.api.nvim_buf_set_var(bufnr, 'SuperTabDefaultCompletionType', '<c-x><c-o>')

  local opts = { noremap=true, silent=true }
  -- buf_set_keymap('i', '<TAB>', '<cmd>lua vim.lsp.omnifunc()<CR>', opts)

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('i', '<C-d>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap('n', '<space>c', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
 
  buf_set_keymap('n', '<space>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('i', '<C-q>', '<c-x><c-o>', opts)

  buf_set_keymap('n', '<C-LeftMouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

vim.lsp.config['gopls'] = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    gopls = {
      buildFlags = {"-tags=integration",}
    }
  }
}

vim.lsp.enable('gopls')

local servers = {'rust_analyzer', 'clangd'} -- , 'jedi_language_server'}
for _, lsp in ipairs(servers) do
  vim.lsp.config[lsp] = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
  vim.lsp.enable(lsp)
end

-- JDTLS setup

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
local jdtls_home = os.getenv("HOME") .. "/jdtls"
local jdtls_launcher = vim.fn.glob(jdtls_home .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = jdtls_home .. "/config_linux"

local jdtls_start_cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-jar', jdtls_launcher,
    '-configuration', config_dir,
    '-data', workspace_dir,
}

vim.lsp.config['jdtls'] = {
  cmd = jdtls_start_cmd,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

vim.lsp.enable("jdtls")

-- vim.lsp.config['mypy_ls'] = {
  -- cmd = { "mypy", "--show-column-numbers", "--hide-error-codes", "--hide-error-context", "--no-pretty" },
  -- filetypes = { "python" },
-- }
-- vim.lsp.enable("mypy_ls")

-- vim.lsp.start({
--     name = "pylsp",
--     cmd = { "pylsp" },
--     root_dir = vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.cfg", "mypy.ini", ".git" }, { upward = true })[1]),
--     settings = {
--         pylsp = {
--             plugins = {
--                 pylsp_mypy = {
--                     enabled = true,
--                     live_mode = true,
--                     dmypy = false,
--                     strict = false,
--                 },
--                 pycodestyle = { enabled = false },
--                 pyflakes = { enabled = false },
--                 mccabe = { enabled = false },
--             },
--         },
--     },
-- })

local lspconfig = require("lspconfig")
lspconfig.basedpyright.setup{
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "recommended",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        reportMissingImports = true,
        reportUnusedImport = true,
        reportOptionalMemberAccess = true,
        reportOptionalSubscript = true,
        reportOptionalCall = true,
        reportGeneralTypeIssues = true,
        reportPrivateImportUsage = true,
        reportIncompatibleMethodOverride = true,
        reportIncompatibleVariableOverride = true,
        reportDuplicateImport = true,
        reportInvalidStringEscapeSequence = true,
        reportAny = false,
      }
    }
  }
}

EOF

" Copilot

imap <silent><script><expr> <Leader><Tab> copilot#Accept("\<CR>")
    " let g:copilot_no_tab_map = v:true


lua << EOF

require("CopilotChat").setup {
   debug = true, -- Enable debugging
   model = 'gpt-4.1', -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
   temperature = 0.1, -- GPT temperature
   window = {
    layout = 'horizontal',
   },
}
EOF

" for copilot.vim
" let g:copilot_settings = #{selectedCompletionModel: 'Meta-Llama-3-70B-Instruct'}
let g:copilot_settings = #{selectedCompletionModel: 'gpt-41-copilot'}

nnoremap <space>c :CopilotChatToggle<CR>

" Codeium
" let g:codeium_disable_bindings = 1
" imap <script><silent><nowait><expr> <Leader><Tab> codeium#Accept()
" " imap <script><silent><nowait><expr> <Leader><Tab> codeium#CycleOrComplete()<CR>

" nnoremap <space>c :call codeium#Chat()<CR>
