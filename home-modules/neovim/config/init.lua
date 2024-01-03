if not vim.g.vscode then
	-- bootstrap lazy.nvim, LazyVim and your plugins
	require("config.lazy")

	local ls = require("luasnip")
	local ps = ls.parser.parse_snippet

	ls.add_snippets("rust", {
		ps("letsig", "let ($1, set_$1) = create_signal($0);"),
	})

	ls.add_snippets("nix", {
		ps("enable", "enable = true;$0"),
		ps("bool", "$1 = true;$0"),
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
		ps(
			"wrapped-package",
			[[
    package = inputs.wrapper-manager.lib.build {
      inherit pkgs;
      modules = [{
        wrappers.$1 = {
          basePackage = pkgs.$1;
          pathAdd = with pkgs; [ $2 ];
        };
      }];
    };$0
    ]]
		),
	})
end
