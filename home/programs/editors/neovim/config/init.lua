-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local ls = require("luasnip")
local s = ls.snippet
local ps = ls.parser.parse_snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rust", {
	ps("letsig", "let ($1, set_$1) = create_signal($0);"),
})

ls.add_snippets("nix", {
	ps("mod", "{$0};"),
	ps("list", "[$0];"),
})
