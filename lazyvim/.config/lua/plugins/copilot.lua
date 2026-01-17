return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "\\<TAB>" } },
      panel = { enabled = false },
      should_attach = function(bufnr)
        local path = vim.api.nvim_buf_get_name(bufnr)

        -- Define your restricted paths/files here
        local forbidden_patterns = {
          "./plank/strats.",
          "./plank/scanners.",
          "/home/zzz1/src/tries/2026-05-17-old-git",
          "%.env$",
        }

        for _, pattern in ipairs(forbidden_patterns) do
          if string.find(path, pattern) then
            return false
          end
        end

        return true
      end,
    },
  },
}
