return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    -- Disable preselect
    opts.preselect = cmp.PreselectMode.None
    opts.completion = { completeopt = "menu,menuone,noinsert,noselect" }

    -- Disable <CR> confirming completion
    opts.mapping["<CR>"] = cmp.mapping(function(fallback)
      fallback() -- Just do normal Enter
    end, { "i", "s" })

    -- Helper check
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match("%s") == nil
    end

    -- Tab / Shift-Tab navigation
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
      elseif vim.snippet and vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" })

    opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
      elseif vim.snippet and vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })

    return opts
  end,
}
