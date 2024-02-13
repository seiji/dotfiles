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
  {'altercation/vim-colors-solarized'},
  {'itchyny/lightline.vim'},
  {'justinmk/vim-dirvish'},
  {'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
  {'junegunn/fzf.vim'},
  {'kassio/neoterm'},
  {'tomtom/tcomment_vim'},
  {'tpope/vim-eunuch'},
  {'tpope/vim-fugitive'},
  {'tpope/vim-repeat'},
  {'tpope/vim-surround'}
}
