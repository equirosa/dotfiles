local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("rust", {
  s("letsig", fmt(
    [[
    let ({}, set_{}) = create_signal({});
    ]], {
      i(1), rep(1), i(0)
    }
  ))
})
