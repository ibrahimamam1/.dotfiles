return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
      name = 'lldb'
    }

    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {}
      }
    }

    dapui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    vim.keymap.set('n', '<Leader>dt', dap.toggle_breakpoint, {})
    vim.keymap.set('n', '<Leader>dc', dap.continue, {})
    vim.keymap.set('n', '<Leader>dso', dap.step_over, {})
    vim.keymap.set('n', '<Leader>dsi', dap.step_into, {})
    vim.keymap.set('n', '<Leader>dsu', dap.step_out, {})
    vim.keymap.set('n', '<Leader>dr', dap.repl.open, {})
    vim.keymap.set('n', '<Leader>dui', dapui.toggle, {})
  end
}
