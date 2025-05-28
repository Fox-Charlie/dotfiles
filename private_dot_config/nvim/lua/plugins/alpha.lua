-- ---------------------------------------------------------------------------
--  This module configures alpha-nvim with:
--    • Custom ASCII logo
--    • Handy dashboard buttons
--    • Dynamic footer showing plugin count, startup time & today’s date
--    • Colours via highlight groups
-- ---------------------------------------------------------------------------

local M = {}

function M.setup()
  local ok_alpha, alpha = pcall(require, "alpha")
  if not ok_alpha then
    vim.notify("alpha-nvim not found", vim.log.levels.WARN)
    return
  end

  local dashboard = require("alpha.themes.dashboard")

  -- ════════════════════════════════════════════
  --  Header (ASCII art)
  -- ════════════════════════════════════════════
  dashboard.section.header.val = {
    "███╗   ██╗██╗   ██╗██╗███╗   ███╗",        
    "████╗  ██║██║   ██║██║████╗ ████║",        
    "██╔██╗ ██║██║   ██║██║██╔████╔██║",        
    "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",        
    "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",        
    "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",        
  }
  dashboard.section.header.opts.hl = "Type"

  -- ════════════════════════════════════════════
  --  Buttons (quick actions)
  -- ════════════════════════════════════════════
  local button  = dashboard.button
  local leader  = "SPACE" -- show <leader> as SPACE in labels
  dashboard.section.buttons.val = {
    button("f", "  Find file",      ":Telescope find_files<CR>"),
    button("g", "  Live grep",     ":Telescope live_grep<CR>"),
    button("r", "  Recent files",   ":Telescope oldfiles<CR>"),
    button("n", "  New file",       ":ene <BAR> startinsert<CR>"),
    button("p", "  Plugins",        ":Lazy home<CR>"),
    button("c", "  Config",         ":e $MYVIMRC<CR>"),
    button("q", "  Quit",           ":qa<CR>"),
  }
  for _, b in ipairs(dashboard.section.buttons.val) do
    b.opts.hl = "Function"
    b.opts.hl_shortcut = "Keyword"
  end

  -- ════════════════════════════════════════════
  --  Footer (dynamic)
  -- ════════════════════════════════════════════
  local function footer()
    local stats = require("lazy").stats()
    local datetime = os.date("%A, %d %B %Y    %H:%M")
    return string.format("  %d plugins in %.2fms  |  %s", stats.count, stats.startuptime, datetime)
  end
  dashboard.section.footer.val = { footer() }
  dashboard.section.footer.opts.hl = "Constant"

  -- ════════════════════════════════════════════
  --  Layout tweaks & final setup
  -- ════════════════════════════════════════════
  dashboard.opts.opts.noautocmd = true  -- don’t run autocommands on alpha buffer
  alpha.setup(dashboard.config)
end

return M

