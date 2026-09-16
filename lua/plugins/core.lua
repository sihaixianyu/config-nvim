-- Core editor configuration derived from the preferred Helix workflow.
return {
  -- fleet_transparent is a dark, transparent theme. TokyoNight is bundled with
  -- LazyVim and provides the closest low-maintenance equivalent.
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(highlights)
        -- Prevent any theme highlight group from opting back into italics.
        for _, highlight in pairs(highlights) do
          if type(highlight) == "table" then
            highlight.italic = nil
          end
        end

        -- Keep non-current relative line numbers readable.
        highlights.LineNrAbove = { fg = "#545c7e" }
        highlights.LineNrBelow = { fg = "#545c7e" }
        highlights.CursorLineNr = { fg = "#7aa2f7", bold = true }
        highlights.FloatBorder = { fg = "#7aa2f7", bg = "NONE" }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "tokyonight-night"
      -- Neovim 0.11+: apply the same visible border to LSP hover, signature
      -- help, completion documentation, and diagnostic floating windows.
      vim.opt.winborder = "rounded"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- A maintained, syntax-colored minimap in a fixed right-hand split.
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    init = function()
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = true,
        layout = "split",
        x_multiplier = 1,
        y_multiplier = 1,
        current_line_position = "percent",
        split = {
          direction = "right",
          minimap_width = 32,
          fix_width = true,
          persist = true,
        },
        diagnostic = { enabled = true, mode = "line" },
        git = { enabled = true, mode = "line" },
        search = { enabled = true, mode = "line" },
        treesitter = { enabled = true },
        -- Keep the map content flush-left; annotations use line highlights
        -- instead of reserving a sign column on the left.
        winopt = function(opt)
          opt.signcolumn = "no"
        end,
        exclude_filetypes = {
          "help",
          "lazy",
          "mason",
          "snacks_dashboard",
          "snacks_picker_input",
          "snacks_picker_list",
          "snacks_picker_preview",
          "terminal",
        },
      }
    end,
    keys = {
      { "<leader>um", "<cmd>Neominimap Toggle<cr>", desc = "Toggle Minimap" },
      { "<leader>uf", "<cmd>Neominimap ToggleFocus<cr>", desc = "Focus Minimap" },
    },
  },

  -- Keep diagnostics out of the text area; the diagnostic under the cursor is
  -- shown in a dedicated floating window (configured in autocmds.lua).
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      diagnostics = {
        virtual_text = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          focusable = false,
          header = "",
          prefix = "",
          source = "if_many",
        },
      },
      servers = {
        clangd = {},
        rust_analyzer = {},
        gopls = {},
        bashls = {},
        jsonls = {},
        taplo = {},
        pyright = {
          on_attach = function(client)
            -- ty owns type diagnostics and inlay hints, avoiding duplicates.
            client.server_capabilities.diagnosticProvider = false
            client.server_capabilities.inlayHintProvider = false
          end,
        },
        ty = {},
        ruff = {
          init_options = { settings = { preview = true } },
          on_attach = function(client)
            -- Pyright/ty provide language hover information.
            client.server_capabilities.hoverProvider = false
          end,
        },
      },
    },
  },

  -- Match Helix auto-format-on-save. Ruff formats Python; Taplo formats TOML.
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
      formatters_by_ft = {
        python = { "ruff_format" },
        toml = { "taplo" },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "rust-analyzer",
        "gopls",
        "pyright",
        "ty",
        "ruff",
        "bash-language-server",
        "json-lsp",
        "taplo",
      },
    },
  },

  -- Noice replaces vim.lsp.buf.hover and renders its own window, so the
  -- border must be configured on Noice's LSP-hover route.
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.views = opts.views or {}
      opts.views.hover = vim.tbl_deep_extend("force", opts.views.hover or {}, {
        border = { style = "rounded" },
        win_options = {
          winblend = 0,
          winhighlight = {
            Normal = "NoicePopup",
            FloatBorder = "LspHoverBorder",
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "c",
        "cpp",
        "go",
        "json",
        "python",
        "rust",
        "toml",
      })
    end,
  },
}
