local config = require("vague.config.internal").current
local colors = config.colors

return {
  visual = {
    a = { fg = colors.bg, bg = colors.builtin, bold = config.bold },
    b = { fg = colors.property, bg = colors.line },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.string, bold = config.bold },
    b = { fg = colors.property, bg = colors.line },
  },
  inactive = {
    a = { fg = colors.property, bg = colors.inactiveBg, bold = config.bold },
    b = { fg = colors.property, bg = colors.inactiveBg },
    c = { fg = colors.property, bg = colors.inactiveBg },
  },
  normal = {
    a = { fg = colors.bg, bg = colors.operator, bold = config.bold },
    b = { fg = colors.property, bg = colors.line },
    c = { fg = colors.property, bg = colors.inactiveBg },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.delta, bold = config.bold },
    b = { fg = colors.property, bg = colors.line },
  },
}
