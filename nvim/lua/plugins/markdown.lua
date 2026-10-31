-- Markdown viewing helpers.
-- <leader>cp is already provided by LazyVim (lang.markdown) -> MarkdownPreviewToggle.
-- <leader>cg opens the current buffer in glow, inside a floating terminal.

local function glow_preview()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    vim.notify("Glow: buffer has no file on disk", vim.log.levels.WARN)
    return
  end

  local source = name
  if vim.bo.modified then
    source = vim.fn.tempname() .. ".md"
    vim.fn.writefile(vim.api.nvim_buf_get_lines(0, 0, -1, false), source)
  end

  -- glow drops colors when stdout is not a TTY, and we pipe into less, so the
  -- style must be explicit: "auto" resolves to the notty (plain) style here.
  local style = vim.o.background == "light" and "light" or "dark"

  Snacks.terminal.open({
    "sh",
    "-c",
    "glow --pager=false -s " .. style .. " " .. vim.fn.shellescape(source) .. " | less -R",
  }, {
    win = { position = "float", border = "rounded" },
  })
end

return {
  {
    "folke/snacks.nvim",
    optional = true,
    init = function()
      vim.api.nvim_create_user_command("Glow", glow_preview, {
        desc = "Preview current markdown with glow",
      })
    end,
    keys = {
      {
        "<leader>cg",
        glow_preview,
        ft = { "markdown", "markdown.mdx" },
        desc = "Glow preview",
      },
    },
  },
}
