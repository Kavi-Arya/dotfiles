local M = {
  "David-Kunz/gen.nvim",
    event = "BufEnter",
  opts = {
    model = "deepseek-r1:8b",
  },
    config = function()
        require("gen").setup({
      vim.keymap.set({ 'n', 'v' }, '<leader>gg', ':Gen<CR>'),
        })
    end
}
return M
