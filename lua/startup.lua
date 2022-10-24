local starter = require("mini.starter")

starter.setup({
	evaluate_single = true,
	items = {
		starter.sections.builtin_actions(),
		starter.sections.recent_files(6, false),
		starter.sections.telescope(),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.indexing("all", { "Builtin actions" }),
		starter.gen_hook.padding(3, 2),
	},
})
