-- Debug Kotlin (e.g. a local Spring Boot app) by attaching over JDWP.
--
-- Start the app with the JDWP agent listening on 5005:
--   ./gradlew bootRun --debug-jvm            (Gradle: port 5005, suspend=y)
--   ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
--
-- Then open a .kt file, <leader>db to set a breakpoint, <leader>dc to attach.
return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'kotlin-debug-adapter' } },
  },

  {
    -- mason-nvim-dap.setup() runs inside nvim-dap's `config`, i.e. after every
    -- `opts` function, so its stock kotlin adapter wins over anything defined
    -- below. Override its handler instead of fighting it.
    'jay-babu/mason-nvim-dap.nvim',
    optional = true,
    opts = {
      handlers = {
        kotlin = function(config)
          -- Keep mason's resolved binary, but don't let nvim-dap auto-continue:
          -- a Spring Boot JVM reports dozens of stopped threads and the default
          -- heuristic resumes past the one that actually hit the breakpoint.
          require('dap').adapters.kotlin = vim.tbl_extend('force', config.adapters, {
            options = { auto_continue_if_many_stopped = false },
          })
          -- Deliberately skip config.configurations: mason's only kotlin entry
          -- is a "launch" that prompts for a main class, which we don't want.
          --
          -- Bind a key to manually pick or refresh the active thread context if the UI gets stuck
          vim.keymap.set('n', '<leader>dh', function()
            -- This forces nvim-dap to prompt you to select which thread context to switch to
            require('dap').pick_thread()
          end, { desc = 'DAP: Switch/Pick Active Thread' })
        end,
      },
    },
  },

  {
    'mfussenegger/nvim-dap',
    opts = function()
      require('dap').configurations.kotlin = {
        {
          type = 'kotlin',
          request = 'attach',
          name = 'Attach to JVM (localhost:5005)',
          hostName = '127.0.0.1',
          -- Force the JVM to suspend all threads on JDWP events
          -- This prevents other virtual threads from racing ahead and breaking nvim-dap's active frame
          vmArgs = '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=127.0.0.1:5005,suspend=all',
          port = 5005,
          timeout = 2000,
          -- The adapter resolves the project classpath from here in order to
          -- map breakpoints in .kt files onto classes loaded in the JVM.
          projectRoot = function()
            return LazyVim.root.get()
          end,
        },
      }
    end,
  },
}
