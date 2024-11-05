return {
  "hrsh7th/nvim-cmp",
  -- lazy = false,
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "windwp/nvim-autopairs"
  },
  config = function()    
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require'cmp'
    cmp.setup({
      preselect = cmp.PreselectMode.None,
      completion = {
        completeopt = 'menu,menuone,noinsert,noselect',
      },
      sources = cmp.config.sources(
        {{ name = 'nvim_lsp', keyword_length = 1 }},
        {{ name = 'buffer', keyword_length = 2 }}
      ),
      mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          --[[ Replace with your snippet engine (see above sections on this page)
          elseif snippy.can_expand_or_advance() then
            snippy.expand_or_advance() ]]
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end, { "i", "s" }),
      }

    })

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp = require('lspconfig')
    -- require("nvchad.configs.lspconfig").defaults()

    local servers = {
      "basedpyright",
      -- "pylsp",
      "yamlls",
      "dockerls",
      "docker_compose_language_service",
      "lua_ls",
      "bashls"
    }
    -- local nvlsp = require "nvchad.configs.lspconfig"

    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
      
    end


    for _, server in ipairs(servers) do
      lsp[server].setup {
        on_attach = on_attach,
        -- on_init = nvlsp.on_init,
        capabilities = capabilities,
      }
    end

    lsp.basedpyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "python" },
      on_new_config = function(new_config, dir)
        new_config.cmd = { "basedpyright-langserver", "--stdio" }
      end,

      basedpyright = {
        disableLanguageServices = false,
        disableTaggedHints = false,
        analysis = {
          diagnosticMode = "openFilesOnly",
          autoImportCompletions = true,
          autoSearchPaths = true,
        }
      }
    })



  end
}
