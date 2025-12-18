local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme nord]]

      -- Example config in lua
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false

      -- Load the colorscheme
      require('nord').set()
    end,
  },
  {'itchyny/lightline.vim'},
  {'justinmk/vim-dirvish'},
  {'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
  {
    'junegunn/fzf.vim',
    config = function()
      vim.g.fzf_history_dir = vim.fn.expand '~/.config/local/share/fzf-history'
      function FzfCd()
        return vim.fn['fzf#run'] {
          sink = 'e',
          source = 'find . -type d -maxdepth 5',
          down = '50%',
        }
      end
      function FzfFileList()
        return vim.fn['fzf#run'] {
          sink = 'e',
          source = 'find . -type d -name .git -prune -o ! -name .DS_Store',
          down = '50%',
        }
      end
      vim.keymap.set( { 'n' }, '<C-x><C-p>', FzfFileList, { silent = true })
      vim.keymap.set( { 'n' }, '<C-x><C-f>', FzfCd, { silent = true })
    end,
  },
  {'kassio/neoterm'},
  {'tomtom/tcomment_vim'},
  {'tpope/vim-eunuch'},
  {'tpope/vim-fugitive'},
  {'tpope/vim-repeat'},
  {'tpope/vim-surround'},
  {
    "hashivim/vim-terraform",
    ft = "terraform",
  },
  {
    'is0n/jaq-nvim',
    config = function()
      local jaq = require "jaq-nvim"
      local keymap = vim.keymap.set
      jaq.setup {
        -- Commands used with 'Jaq'
        cmds = {
          -- Uses external commands such as 'g++' and 'cargo'
          external = {
            typescript = "tsc % && node $fileBase",
            -- Debugging
            -- javascript = "node --inspect %",
            -- Normal
            javascript = "node %",
            python = "uv run $file",
            -- rust = "rustc % && $fileBase",
            -- Competitive Programming
            -- cpp = "g++ -std=c++17 -Wall -DAL -O2 % -o $fileBase && $fileBase<input.txt",
            -- Debugging
            -- cpp = "g++ -g % -o  $fileBase && $fileBase",
            -- Normal
            cpp = "g++ % -o  $fileBase && $fileBase",
            c = "gcc % -o $fileBase && $fileBase",
            go = "go run %",
            ruby = "ruby %",
            perl = "perl %",
            -- cs = "dotnet run",
            -- julia = "julia %",
            php = "php %",
            -- java = "javac % && java %",
            java = "java %",
            r = "Rscript %",
            -- kotlin = "kotlinc % -include-runtime -d $fileBase.jar && java -jar $fileBase.jar",
            -- lua = "lua %",
            -- lisp = "clisp %",
          },

          -- Uses internal commands such as 'source' and 'luafile'
          internal = {
            lua = "luafile %",
            vim = "source %",
          },
        },

        behavior = {
          -- Default type
          default = "terminal",
          -- Start in insert mode
          startinsert = true,
          -- Use `wincmd p` on startup
          wincmd = false,
        },

        -- UI settings
        ui = {
          -- Floating Window / FTerm settings
          float = {
            -- Floating window border (see ':h nvim_open_win')
            border = "rounded",
            -- Num from `0 - 1` for measurements
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5,
            -- Highlight group for floating window/border (see ':h winhl')
            border_hl = "FloatBorder",
            win_hl = "Normal",
            -- Floating Window Transparency (see ':h winblend')
            winblend = 0,
          },
        },
      }
      keymap("n", "<leader>r", "<cmd>Jaq<cr>", { noremap = true, silent = true })
    end,
  },
  {
    'github/copilot.vim',
    lazy=false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      local keymap = vim.keymap.set
      -- https://github.com/orgs/community/discussions/29817#discussioncomment-4217615
      keymap(
        "i",
        "<Tab>",
        function()
          return vim.fn["copilot#Accept"]("")
        end,
        { silent = true, expr = true, script = true, replace_keycodes = false }
      )
      keymap("i", "<C-j>", "<Plug>(copilot-next)")
      keymap("i", "<C-k>", "<Plug>(copilot-previous)")
      keymap("i", "<C-o>", "<Plug>(copilot-dismiss)")
      keymap("i", "<C-s>", "<Plug>(copilot-suggest)")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
  },
  {
    "coder/claudecode.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    config = function()
      require("claudecode").setup({})
    end,
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude Codeを切り替え" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Claudeにフォーカス" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "セッションを再開" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "選択範囲を送信", mode = "v" },
    },
  }
}
