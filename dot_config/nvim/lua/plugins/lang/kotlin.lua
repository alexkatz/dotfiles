-- Kotlin support via JetBrains' kotlin-lsp (kotlin.nvim), which also provides the debug adapter:
-- kotlin-lsp starts a DAP server on request and nvim-dap connects to it.
--
-- Debug Kotlin (e.g. a local Spring Boot app) by attaching over JDWP.
--
-- Start the app with the JDWP agent listening on 5005:
--   ./gradlew bootRun --debug-jvm            (Gradle: port 5005, suspend=y)
--   ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
--
-- Then open a .kt file, <leader>db to set a breakpoint, <leader>dA to attach.
-- `main` functions get Run/Debug code lenses, also available as :KotlinRunMain / :KotlinDebugMain.

return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'kotlin' })
    end,
  },
  {
    'AlexandrosAlexiou/kotlin.nvim',
    ft = { 'kotlin' },
    -- oil.nvim is optional (only used for opening package folders), so it's left out
    dependencies = { 'mason.nvim', 'mason-lspconfig.nvim', 'trouble.nvim' },
    -- kotlin.nvim registers its dap adapter lazily, from its own commands, so attach through
    -- :KotlinDebug rather than a dap.configurations entry (which would fail with no adapter yet)
    keys = {
      { '<leader>dA', '<cmd>KotlinDebug 5005<cr>', ft = 'kotlin', desc = 'Attach to JVM (localhost:5005)' },
    },
    init = function()
      -- kotlin-lsp comes from homebrew (`brew install jetbrains/utils/kotlin-lsp`) rather than mason,
      -- whose download currently 404s. kotlin.nvim falls back to $KOTLIN_LSP_DIR when mason has no
      -- kotlin-lsp; point it at the directory containing bin/intellij-server
      local brew_dir = '/opt/homebrew/opt/kotlin-lsp/libexec'
      if not vim.env.KOTLIN_LSP_DIR and vim.fn.isdirectory(brew_dir) == 1 then
        vim.env.KOTLIN_LSP_DIR = brew_dir
      end
    end,
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        -- kotlin.nvim starts kotlin_lsp itself; mason-lspconfig auto-enabling it
        -- would attach a client without the handlers kotlin-lsp needs
        kotlin_lsp = { enabled = false },
      },
    },
  },
  {
    -- if kotlin-debug-adapter is installed in mason, mason-nvim-dap's default handler would
    -- register it as the `kotlin` adapter, and kotlin.nvim only registers its own when none exists
    'jay-babu/mason-nvim-dap.nvim',
    optional = true,
    opts = {
      handlers = {
        kotlin = function() end,
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    opts = function()
      -- Don't let nvim-dap auto-continue: a Spring Boot JVM reports dozens of
      -- stopped threads and the default heuristic resumes past the one that
      -- actually hit the breakpoint.
      require('dap').defaults.kotlin.auto_continue_if_many_stopped = false
    end,
  },
}
