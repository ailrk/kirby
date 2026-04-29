require('minuet').setup({
  provider = 'openai_compatible',
  provider_options = {
    openai_compatible = {
      model = 'copilot-model',
      end_point = 'http://localhost:11435/v1/chat/completions',
      name = 'LiteLLM',
      stream = true,
      optional = {
        max_tokens = 512,
        stop = { "\n\n" },
      }
    }
  },
  virtualtext = {
    auto_trigger_ft = {},
    keymap = {
      accept = '<A-A>',
      accept_line = '<A-a>',
      accept_n_lines = '<A-z>',
      prev = '<A-[>',
      next = '<A-]>',
      dismiss = '<A-e>',
    },
  }
})
