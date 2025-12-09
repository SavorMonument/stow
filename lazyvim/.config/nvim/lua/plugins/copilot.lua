return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      local copilot = require("copilot")

      copilot.setup({
        suggestion = { enabled = true, auto_trigger = false },
        panel = { enabled = false },
      })

      -- Map <leader><Tab> to trigger and accept suggestion
      vim.keymap.set("i", "\\<Tab>", function()
        local suggestion = require("copilot.suggestion")
        if not suggestion.is_visible() then
          suggestion.next()    -- generate a suggestion
        end
        if suggestion.is_visible() then
          suggestion.accept()  -- accept it
        end
      end, { silent = true, noremap = true })
    end,
  },
}
