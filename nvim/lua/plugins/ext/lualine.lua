-- [nfnl] Compiled from fnl/plugins/ext/lualine.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.o["laststatus"] = 3
  local lualine = require("lualine")
  local colors = {bg = "#303446", itembg = "#626880", fg = "#c6d0f5", yellow = "#e5c890", cyan = "#99d1db", darkblue = "#081633", green = "#a6d189", orange = "#ef9f76", violet = "#a9a1e1", magenta = "#f4b8e4", blue = "#8caaee", red = "#ec5f67"}
  local conditions
  local function _2_()
    return (vim.fn.empty(vim.fn.expand("%:t")) ~= 1)
  end
  local function _3_()
    return (vim.fn.winwidth(0) > 80)
  end
  local function _4_()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", (filepath .. ";"))
    local and_5_ = gitdir()
    if and_5_ then
      local function _6_()
        return gitdir
      end
      and_5_ = (_6_ > 0)
    end
    if and_5_ then
      local function _7_()
        return gitdir
      end
      local function _8_()
        return filepath
      end
      and_5_ = (_7_ < _8_)
    end
    return and_5_
  end
  conditions = {buffer_not_empty = _2_, hide_in_width = _3_, check_git_workspace = _4_}
  local config = {options = {component_separators = "", section_separators = "", theme = {normal = {c = {fg = colors.fg, bg = colors.bg}}, inactive = {c = {fg = colors.fg, bg = colors.bg}}}}, sections = {lualine_a = {}, lualine_b = {}, lualine_y = {}, lualine_z = {}, lualine_c = {}, lualine_x = {}}, inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_y = {}, lualine_z = {}, lualine_c = {}, lualine_x = {}}}
  local function ins_left(component)
    return table.insert(config.sections.lualine_c, component)
  end
  local function ins_right(component)
    return table.insert(config.sections.lualine_x, component)
  end
  local function _9_()
    return ("\239\140\140 (" .. vim.fn.mode() .. ")")
  end
  local function _10_()
    local mode_color = {n = colors.red, i = colors.green, v = colors.blue, ["\226\144\150"] = colors.blue, V = colors.blue, c = colors.magenta, no = colors.red, s = colors.orange, S = colors.orange, ["\226\144\147"] = colors.orange, ic = colors.yellow, R = colors.violet, Rv = colors.violet, cv = colors.red, ce = colors.red, r = colors.cyan, rm = colors.cyan, ["r?"] = colors.cyan, ["!"] = colors.red, t = colors.red}
    local _12_
    do
      local t_11_ = mode_color
      if (nil ~= t_11_) then
        t_11_ = t_11_[vim.fn.mode()]
      else
      end
      _12_ = t_11_
    end
    return {fg = _12_}
  end
  ins_left({_9_, color = _10_, padding = {right = 1}})
  ins_left({"filesize", cond = conditions.buffer_not_empty})
  ins_left({"filename", cond = conditions.buffer_not_empty, color = {fg = colors.magenta, gui = "bold"}})
  ins_left({"location"})
  ins_left({"progress", color = {fg = colors.fg, gui = "bold"}})
  ins_left({"diagnostics", sources = {"nvim_diagnostic"}, symbols = {error = "\239\129\151 ", warn = "\239\129\177 ", info = "\239\129\170 "}, diagnostics_color = {color_error = {fg = colors.red}, color_warn = {fg = colors.yellow}, color_info = {fg = colors.cyan}}})
  local function _14_()
    return "%="
  end
  ins_left({_14_})
  local function _15_()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    local function first_with_filetype(filetype, list, index)
      local i, value = next(list, index)
      if (i == nil) then
        return nil
      else
        local filetypes = value.config.filetypes
        if (filetypes and (vim.fn.index(filetypes, filetype) ~= -1)) then
          return value.name
        else
          return first_with_filetype(filetype, list, i)
        end
      end
    end
    local client = first_with_filetype(buf_ft, clients)
    if (client == nil) then
      return msg
    else
      return client
    end
  end
  ins_left({_15_, icon = "\239\130\133 LSP:", color = {fg = "#ffffff", gui = "bold"}})
  ins_right({"o:encoding", fmt = string.upper, cond = conditions.hide_in_width, color = {fg = colors.green, gui = "bold"}})
  ins_right({"fileformat", fmt = string.upper, color = {fg = colors.green, gui = "bold"}, icons_enabled = false})
  ins_right({"branch", icon = "\239\145\191", color = {fg = colors.violet, gui = "bold"}})
  ins_right({"diff", symbols = {added = "\239\131\190 ", modified = "\243\176\157\164 ", removed = "\239\133\134 "}, diff_color = {added = {fg = colors.green}, modified = {fg = colors.orange}, removed = {fg = colors.red}}, cond = conditions.hide_in_width})
  return lualine.setup(config)
end
return {"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, config = _1_}
