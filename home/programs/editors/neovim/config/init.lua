-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rust", {
  s("letsig", fmt(
    [[
    let ({}, set_{}) = create_signal({});
    ]], {
      i(1), rep(1), i(0)
    }
  ))
})
