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
    'github/copilot.vim',
    lazy=false,
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
}
