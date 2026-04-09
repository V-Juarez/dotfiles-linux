-- -- ~/.config/nvim/lua/plugins/codeium.lua
--
-- return {
--   "Exafunction/codeium.vim", -- Plugin de Codeium
--   opts = function()
--     -- Configuración básica de Codeium
--     vim.g.codeium_enabled = true -- Habilitar Codeium
--
--     -- Configuración de los tipos de archivo para Codeium
--     vim.g.codeium_filetypes = {
--       lua = true,        -- Activar autocompletado para archivos Lua
--       python = true,     -- Activar autocompletado para archivos Python
--       javascript = true, -- Activar autocompletado para archivos JavaScript
--       markdown = false,  -- Deshabilitar para Markdown
--       gitcommit = false, -- Deshabilitar para Git commits
--     }
--
--     -- Si necesitas una clave API para autenticación
--     -- vim.g.codeium_api_key = "tu_clave_api_aqui"
--
--     -- Configuración adicional para tiempos de espera
--     vim.g.codeium_wait_for_completions = 200 -- Configura el tiempo de espera antes de autocompletar (ms)
--
--     -- Si deseas mapear teclas para aceptar sugerencias:
--     vim.api.nvim_set_keymap("i", "<Tab>", "codeium#Accept()", { noremap = true, silent = true })
--   end
-- }
--
--
-- ~/.config/nvim/lua/plugins/codeium.lua
return {
  "Exafunction/codeium.vim", -- Plugin de Codeium
  event = "BufEnter",
  config = function()
    -- Configuración básica de Codeium
    vim.g.codeium_enabled = true -- Habilitar Codeium

    -- Configuración de los tipos de archivo para Codeium
    vim.g.codeium_filetypes = {
      lua = true,        -- Activar autocompletado para archivos Lua
      python = true,     -- Activar autocompletado para archivos Python
      javascript = true, -- Activar autocompletado para archivos JavaScript
      typescript = true, -- Activar autocompletado para archivos TypeScript
      markdown = false,  -- Deshabilitar para Markdown
      gitcommit = false, -- Deshabilitar para Git commits
    }

    -- Si necesitas una clave API para autenticación
    -- vim.g.codeium_api_key = "tu_clave_api_aqui"

    -- Configuración adicional para tiempos de espera
    vim.g.codeium_wait_for_completions = 200 -- Tiempo de espera antes de autocompletar (ms)

    -- Deshabilitar los atajos de teclado por defecto si quieres usar los tuyos
    vim.g.codeium_disable_bindings = 0

    -- Mapeo de teclas para aceptar sugerencias
    vim.keymap.set("i", "<Tab>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true, desc = "Aceptar sugerencia de Codeium" })

    -- Ciclar entre sugerencias (siguiente)
    vim.keymap.set("i", "<M-]>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, silent = true, desc = "Siguiente sugerencia" })

    -- Ciclar entre sugerencias (anterior)
    vim.keymap.set("i", "<M-[>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, silent = true, desc = "Sugerencia anterior" })

    -- Limpiar sugerencias
    vim.keymap.set("i", "<C-]>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, silent = true, desc = "Limpiar sugerencias" })
  end,
}
