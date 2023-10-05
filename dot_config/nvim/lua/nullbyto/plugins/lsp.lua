return {
    {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
      local cmp_select = {behavior = cmp.SelectBehavior.Select}

      cmp.setup({
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
        })
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { unpack(opts), desc = "Go to definition" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { unpack(opts), desc = "Hover over variable" })
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, { unpack(opts), desc = "Workspace symbol" })
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, { unpack(opts), desc = "Open diagnostics" })
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { unpack(opts), desc = "Prev definition" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { unpack(opts), desc = "Next definition" })
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, { unpack(opts), desc = "Code action" })
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, { unpack(opts), desc = "Variable References" })
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { unpack(opts), desc = "Rename variable" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end)

      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })
    end
  }
}
