local builtin = require("statuscol.builtin")
require("statuscol").setup({
	-- foldfunc = "builtin",
	setopt = true,
	relculright = true,
	segments = {
		{ text = { "%s" }, click = "v:lua.ScSa" },
		{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
		{
			text = { " ", builtin.foldfunc },
			click = "v:lua.ScFa",
		},
	},
	clickhandlers = {
		Lnum = function(args)
			if args.button == "l" and args.mods:find("c") then
				print("I Ctrl-left clicked on line " .. args.mousepos.line)
			end
		end,
	},
})
