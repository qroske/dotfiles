return {
 	-- Setup tokyonight
 	{
 	 	"folke/tokyonight.nvim",
 	 	lazy = false,
 	 	priority = 1000,
 	 	opts = {
 	 	 	style = "night",
 	 	},
 	},
 	-- Setup colorscheme
 	{
 	 	"LazyVim/LazyVim",
 	 	opts = {
 	 	 	colorscheme = "tokyonight",
 	 	},
 	},
}
