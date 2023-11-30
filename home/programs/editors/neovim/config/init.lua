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
	ps("list", "$1 = [$2];$0"),
	ps("set", "$1 = {\n$2\n};$0"),
	ps("str", '$1 = "$2";$0'),
	ps("mls", "$1 = ''\n$2\n'';$0"),
	ps(
		"hm-systemd-service",
		[[
    systemd.user.services.$1 = {
    Unit = {
      Description = "$2";
      After = [ "$3" ];
    };
    Service = {
      ExecStart = "$4";
      Restart = "$5";
      RestartSec = $6;
    };
    Install = {
          WantedBy = [ "$7" ];
        };
      };$0
    ]]
	),
})
