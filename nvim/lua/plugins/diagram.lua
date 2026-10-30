-- Inline Mermaid diagram rendering inside nvim (requires mmdc on PATH).
-- Uses the Kitty graphics protocol, supported by Ghostty/Kitty.
-- Trigger with <leader>dm or K over a fenced mermaid block.

-- Pre-run: npm i -g @mermaid-js/mermaid-cli  (already done globally, exposes mmdc)

return {
  {
    "3rd/image.nvim",
    dependencies = { "vhyrro/ueberzugpp" },
    build = false,
    opts = {
      backend = "kitty",
      max_width = 100,
      max_height = 30,
      max_height_window_percentage = 40,
    },
    ft = { "markdown", "markdown.mdx" },
  },
  {
    "3rd/diagram.nvim",
    dependencies = { "3rd/image.nvim" },
    ft = { "markdown", "markdown.mdx" },
    opts = {
      integrations = { require("diagram.integrations.markdown") },
      renderer_options = {
        mermaid = {
          theme = "dark",
          scale = 3,
        },
      },
    },
    keys = {
      {
        "<leader>dm",
        function()
          require("diagram").show_diagram_hover()
        end,
        mode = "n",
        ft = { "markdown", "markdown.mdx" },
        desc = "Render diagram under cursor (mermaid/plantuml/etc.)",
      },
    },
  },
}
