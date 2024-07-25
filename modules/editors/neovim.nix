# neovim home configuration
{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf lists;
  cfg = config.modules.editors.neovim;
  personal = config.modules.personal.enable;
  git = config.modules.shell.git.enable;
  commonPlugins = with pkgs.unstable.vimPlugins; [
    nvim-web-devicons
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = ''
        -- enable highlighting
         require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
      '';
    }

    {
      plugin = telescope-nvim;
      type = "lua";
      config = ''
        require("telescope").setup({
        	defaults = {
        		mappings = {
        			i = {
        				["<C-u>"] = false,
        				["<C-d>"] = false,
        				["<C-j>"] = require("telescope.actions").move_selection_next,
        				["<C-k>"] = require("telescope.actions").move_selection_previous,
        			},
        		},
        	},
        })
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope Find files" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find git files" })
        vim.keymap.set("n", "<leader>ps", function()
        	builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "Telescope grep search" })
        vim.keymap.set("n", "<leader>pws", function()
        	builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end, { desc = "Telescope word search" })
        vim.keymap.set("n", "<leader>pg", builtin.git_status, { desc = "Telescope git status" })
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live Grep" })
        vim.keymap.set("n", "<leader>/", function()
        	-- You can pass additional configuration to telescope to change theme, layout, etc.
        	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        		winblend = 10,
        		previewer = true,
        	}))
        end, { desc = "[/] Fuzzily search in current buffer]" })
        vim.keymap.set("n", "<leader>pc", builtin.git_commits, { desc = "Git Commits" })
        vim.keymap.set("n", "<leader>pb", builtin.git_branches, { desc = "Git Brances" })
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Telescope help tags" })
      '';
    }
    {
      plugin = base16-nvim;
      type = "lua";
      config = ''
        vim.cmd.colorscheme("base16-everforest")
      '';
    }
    {
      plugin = lualine-nvim;
      type = "lua";
      config = ''
        require("lualine").setup({
          options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
          statusline = {},
          winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          },
          },
          sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
           { "filename", path = 1 },
           {
            "lsp_progress",
            spinner_symbols = { "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘" },
           },
          },
          lualine_x = { "encoding", "fileformat", "filetype", "fileicon" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
          },
          inactive_sections = {
           lualine_a = {},
           lualine_b = {},
           lualine_c = { "filename" },
           lualine_x = { "location" },
           lualine_y = {},
           lualine_z = {},
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {},
        })
      '';
    }

    diffview-nvim
    plenary-nvim

    transparent-nvim

    vim-tmux-navigator

    vim-illuminate

    dressing-nvim

    {
      plugin = which-key-nvim;
      type = "lua";
      config = ''
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      '';
    }

    {
      plugin = conform-nvim;
      type = "lua";
      config = ''
              		local conform = require("conform")

        conform.setup({
        	timeout_ms = 1000,
        	lsp_fallback = true,
        	formatters_by_ft = {
        		lua = { "stylua" },
        		nix = { "alejandra" },
        		svelte = { { "prettierd", "prettier" } },
        		javascript = { { "prettierd", "prettier" } },
        		typescript = { { "prettierd", "prettier" } },
        		javascriptreact = { { "prettierd", "prettier" } },
        		typescriptreact = { { "prettierd", "prettier" } },
        		json = { { "prettierd", "prettier" } },
        		graphql = { { "prettierd", "prettier" } },
        		java = { "google-java-format" },
        		kotlin = { "ktlint" },
        		ruby = { "standardrb" },
        		markdown = { { "prettierd", "prettier" } },
        		erb = { "prettierd", "prettier" },
        		html = { "prettierd", "prettier" },
        		bash = { "beautysh" },
        		proto = { "buf" },
        		python = {
                  -- To fix lint errors "ruff_fix",
                  "ruff_format"
                },
        		rust = { "rustfmt" },
        		yaml = { "yamlfix" },
        		toml = { "taplo" },
                typst = { "typstyle "},
        		css = { { "prettierd", "prettier" } },
        		scss = { { "prettierd", "prettier" } },
        	},
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
        	group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
        	pattern = { "*" },
        	desc = "Run conform formatting on a file on save",
        	callback = function(args)
        		conform.format({
        			bufnr = args.buf,
        			lsp_fallback = true,
        			quiet = true,
        		})
        	end,
        })

        vim.keymap.set({ "n", "v" }, "<leader>l", function()
        	conform.format({
        		lsp_fallback = true,
        		quiet = true,
        	})
        end, { desc = "Format file or range (in visual mode)" })

      '';
    }
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = ''
              		require("nvim-autopairs").setup({})

        local npairs = require("nvim-autopairs")
        local rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")
        npairs.add_rules({ rule("|", "|", { "rust", "go", "lua" }):with_move(cond.after_regex("|")) })
        npairs.add_rules({ rule("<", ">", { "rust" }):with_move(cond.after_regex("<")) })
        npairs.add_rules({ rule("$", "$", { "typst" }):with_move(cond.after_regex("$")) })
      '';
    }
    {
      plugin = indent-blankline-nvim;
      type = "lua";
      config = ''
        require("ibl").setup()
      '';
    }
    {
      plugin = oil-nvim;
      type = "lua";
      config = ''
             require("oil").setup({
                 default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
        	-- Show files and directories that start with "."
        	show_hidden = true,
        	natural_order = true,
        	is_always_hidden = function(name, _)
        		return name == ".git"
        	end,
        },
        win_options = {
        	wrap = true,
        },
             	keymaps = {
             		["g?"] = "actions.show_help",
             		["<CR>"] = "actions.select",
             		["<C-s>"] = false,
             		["<C-h>"] = false,
             		["<C-t>"] = false,
             		["<C-p>"] = false,
             		["<C-c>"] = false,
             		["<C-l>"] = false,
             		["-"] = "actions.parent",
             		["_"] = "actions.open_cwd",
             		["`"] = "actions.cd",
             		["~"] = "actions.tcd",
             		["gs"] = "actions.change_sort",
             		["gx"] = false,
             		["g."] = "actions.toggle_hidden",
             		["g\\"] = "actions.toggle_trash",
             	},
             })

      '';
    }

    {
      plugin = todo-comments-nvim;
      type = "lua";
      config = ''
        require("todo-comments").setup()
        vim.keymap.set("n", "<leader>tdf", "<cmd>TodoTelescope<cr>")

        vim.keymap.set("n", "]t", function()
        	require("todo-comments").jump_next()
        end, { desc = "Next todo comment" })

        vim.keymap.set("n", "[t", function()
        	require("todo-comments").jump_prev()
        end, { desc = "Previous todo comment" })
      '';
    }

    nvim-cmp
    cmp_luasnip
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-path
    luasnip
    friendly-snippets
    lspkind-nvim
    lualine-lsp-progress
    lspkind-nvim
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = ''
         local lspkind = require("lspkind")
         local on_attach = function(client, bufnr)
            -- NOTE: Remember that lua is a real programming language, and as such it is possible
            -- to define small helper and utility functions so you don't have to repeat yourself
            -- many times.
            --
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            nmap("<leader>vrn", vim.lsp.buf.rename, "[R]e[n]ame")
            nmap("<leader>vca", vim.lsp.buf.code_action, "[C]ode [A]ction")

            nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
            nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
            nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
            nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
            nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

            -- See `:help K` for why this keymap
            vim.keymap.set("i", "<C-h>", function()
                vim.lsp.buf.signature_help()
            end, { desc = "LSP: Signature Help" })

            -- Lesser used LSP functionality
            nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
            nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
            nmap("<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "[W]orkspace [L]ist Folders")
            nmap("<leader>vd", function()
                vim.diagnostic.open_float()
            end)

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })

            nmap("<leader>hl", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "Toggle [I]nlay [H]ints")
         end

         -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
         local capabilities = vim.lsp.protocol.make_client_capabilities()
         capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

         -- common lsp setup
         local lsp_config = require'lspconfig'
         local with_config = function(config)
           config['capabilities'] = capabilities
           config['on_attach'] = on_attach
           return config
         end
         lsp_config.gopls.setup({
             capabilites = capabilities,
             on_attach = on_attach,
         })
         lsp_config.tsserver.setup({
             capabilites = capabilities,
             on_attach = on_attach,
         })
         lsp_config.ccls.setup({
             capabilites = capabilities,
             on_attach = on_attach,
         })
         lsp_config.gleam.setup({
             capabilites = capabilities,
             on_attach = on_attach,
         })
         lsp_config.jdtls.setup({
             capabilites = capabilities,
             on_attach = on_attach,
         })
         lsp_config.ruff.setup({
             capabilites = capabilities,
             on_attach = on_attach,
         })
         lsp_config.pyright.setup({
             capabilites = capabilities,
             on_attach = on_attach,
         })
         lsp_config.rust_analyzer.setup(with_config({
           settings = {
             ["rust-analyzer"] = {
               checkOnSave = {
                 command =  "clippy",
               },
             },
           },
         }))
         lsp_config.nil_ls.setup(with_config({
           settings = {
             ['nil'] = {
               formatting = {
                 command = { "${lib.getExe pkgs.alejandra}" }
               },
             },
           },
         }))

         lsp_config.html.setup(with_config({ cmd = { "html-languageserver", "--stdio" } }))

        lsp_config.tinymist.setup(with_config({
          settings = {
            exportPdf = "never", -- prevent the lsp PDF generation from coliding with typst plugin
            formatterMode = "typstyle",
          },
        }))

         local cmp = require("cmp")
         local luasnip = require("luasnip")
         require("luasnip.loaders.from_vscode").lazy_load()
         luasnip.config.setup({})

         local cmp_select = { behavior = cmp.SelectBehavior.Select }

         cmp.setup({
           snippet = {
               expand = function(args)
                   luasnip.lsp_expand(args.body)
               end,
           },
           mapping = cmp.mapping.preset.insert({
               ["<C-f>"] = cmp.mapping.select_next_item(cmp_select),
               ["<C-g>"] = cmp.mapping.select_prev_item(cmp_select),
               ["<C-d>"] = cmp.mapping.scroll_docs(-4),
               ["<C-n>"] = cmp.mapping.scroll_docs(4),
               ["<C-Space>"] = cmp.mapping.complete({}),
               ["<C-l>"] = cmp.mapping.confirm({
                   behavior = cmp.ConfirmBehavior.Replace,
                   select = true,
               }),
               ["<S-Tab>"] = cmp.mapping(function(fallback)
                   if cmp.visible() then
                       cmp.select_prev_item()
                   elseif luasnip.locally_jumpable(-1) then
                       luasnip.jump(-1)
                   else
                       fallback()
                   end
               end, { "i", "s" }),
           }),
           sources = {
               { name = "path" },
               { name = "nvim_lsp_signature_help" },
               { name = "nvim_lsp" },
               { name = "luasnip" },
               { name = "copilot" }, -- Copilot suggestions
           },
           formatting = {
               expandable_indicator = true,
               format = lspkind.cmp_format({
                   mode = "symbol_text",
                   maxwidth = 50,
                   ellipsis_char = "...",
                   symbol_map = {
                       Copilot = "",
                   },
               }),
           },
         })

         vim.diagnostic.config({
           -- update_in_insert = true,
           float = {
               focusable = false,
               border = "rounded",
               source = "always",
           },
         })
      '';
    }

    {
      plugin = trouble-nvim;
      type = "lua";
      config = ''
        require("trouble").setup()
        vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {desc = "Diagnostics (Trouble)"})
        vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {desc = "Buffer Diagnostics (Trouble)"})
        vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", {desc = "Symbols (Trouble)"})
        vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {desc = "LSP Definitions / references / ... (Trouble)"})
        vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", {desc = "Location List (Trouble)"})
        vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", {desc = "Quickfix List (Trouble)"})
      '';
    }
    {
      plugin = harpoon2;
      type = "lua";
      config = ''
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon add file" })

        vim.keymap.set("n", "<C-s>", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<C-w>", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<C-t>", function()
            harpoon:list():select(3)
        end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-g>", function()
            harpoon:list():prev()
        end)
        vim.keymap.set("n", "<C-i>", function()
            harpoon:list():next()
        end)
      '';
    }
    {
      plugin = typst-vim;
      type = "lua";
      config = ''
        vim.keymap.set('n', '<leader>tw', function() vim.fn['typst#TypstWatch']() end, { silent = true })
      '';
    }
  ];
  gitPlugins = with pkgs.unstable.vimPlugins;
    lists.optionals git [
      {
        plugin = neogit;
        type = "lua";
        config = ''
          require('neogit').setup {}
          vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "NeoGit", silent = true })
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
                		require("gitsigns").setup({
          	signs = {
          		add = { text = "+" },
          		change = { text = "~" },
          		delete = { text = "_" },
          		topdelete = { text = "‾" },
          		changedelete = { text = "~" },
          	},
          	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
          	vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { desc = "Preview git hunk" }),
          })
        '';
      }
      {
        plugin = obsidian-nvim;
        type = "lua";
        config = ''
                require("obsidian").setup({
                		workspaces = {
                			{
                				name = "Notes",
                				path = "~/Dropbox/Notes",
                			},
                		},
                		completion = {
                			-- Set to false to disable completion.
                			nvim_cmp = true,

                			-- Trigger completion at 2 chars.
                			min_chars = 2,
                		},

                		vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { desc = "[O]bsidian [O]pen" }),
                		vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { desc = "[O]bsidian [N]ew" }),
                		vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<CR>", { desc = "[O]bsidian [B]acklinks" }),
                		vim.keymap.set("n", "<leader>otd", ":ObsidianToday<CR>", { desc = "[O]bsidian [T]o[m]orrow" }),
                		vim.keymap.set("n", "<leader>otm", ":ObsidianTomorrow<CR>", { desc = "[O]bsidian [T]o[d]ay" }),
                		vim.keymap.set("n", "<leader>oyd", ":ObsidianYesterday<CR>", { desc = "[O]bsidian [Y]ester[d]ay" }),
                		vim.keymap.set( "n", "<leader>owp", ":ObsidianWorkspace Project<CR>", { desc = "[O]bsidian [W]orkspace [P]roject" }),
                		vim.keymap.set( "n", "<leader>owa", ":ObsidianWorkspace Area<CR>", { desc = "[O]bsidian [W]orkspace [A]rea" }),
                		vim.keymap.set( "n", "<leader>owr", ":ObsidianWorkspace Resource<CR>", { desc = "[O]bsidian [W]orkspace [R]esource" }),
                		vim.keymap.set( "n", "<leader>owc", ":ObsidianWorkspace Archive<CR>", { desc = "[O]bsidian [W]orkspace [A]rchive" }),
          })
        '';
      }
    ];
  personalPackages = with pkgs;
    lists.optionals personal [
      ccls # C/C++ LSP
      nodePackages.typescript-language-server # JS/TS LSP
      nodePackages.vscode-html-languageserver-bin # HTML LSP
      nil # Nix LSP
      unstable.typst-lsp # Typst LSP
      unstable.tinymist # Better Typst LSP ?
      gopls # Go LSP
      jdt-language-server # Java LSP
      unstable.nodePackages.prettier # JavaScript et al. formatter
      prettierd # JavaScript et al. formatter as daemon
      unstable.ruff # Python linter and formatter
      pyright # Python LSP
    ];
in {
  options.modules.editors.neovim.enable = mkEnableOption "neovim";

  # Home manager module
  config.hm = mkIf cfg.enable {
    programs.neovim = {
      # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      package = pkgs.unstable.neovim-unwrapped;
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = ''
              vim.g.mapleader = " "
              vim.g.maplocalleader = " "

              vim.opt.nu = true
              vim.opt.relativenumber = true

              vim.opt.tabstop = 4
              vim.opt.softtabstop = 4
              vim.opt.shiftwidth = 4
              vim.opt.expandtab = true

              vim.opt.smartindent = true

              -- Better search
              vim.opt.smartcase = true
              vim.opt.ignorecase = true

              vim.opt.wrap = false

              vim.opt.swapfile = false
              vim.opt.backup = false
              vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
              vim.opt.undofile = true

              vim.opt.hlsearch = false
              vim.opt.incsearch = true

              -- Shows incremental commands on a split
              vim.opt.inccommand = "split"

              -- NOTE: No longer needed since 0.10
              vim.opt.termguicolors = true

              vim.opt.scrolloff = 8
              vim.opt.signcolumn = "yes"
              vim.opt.isfname:append("@-@")

              vim.opt.updatetime = 50

              -- show a column at 80 characters as a guide for long lines
              vim.opt.colorcolumn = "80"
              --- except in Rust where the rule is 100 characters
              vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })

              vim.opt.selection = "exclusive"

              vim.opt.spell = true
              -- vim.opt.spelllang = { "en", "pt" }

              vim.wo.number = true
              vim.wo.signcolumn = "yes"

              vim.o.mouse = "a"

              vim.o.breakindent = true

              -- In visual block doc is "infinite"
              vim.opt.virtualedit = "block"

              vim.opt.conceallevel = 2

              -- Set completeopt to have a better completion experience
              vim.o.completeopt = "menuone,noselect"

              -- Enable cursor line highlight
              vim.opt.cursorline = true

              -- This functions are responsible for briefly highlighting yanked text.
        local augroup = vim.api.nvim_create_augroup

        local autocmd = vim.api.nvim_create_autocmd
        local yank_group = augroup("HighlightYank", {})

        autocmd("TextYankPost", {
        	group = yank_group,
        	pattern = "*",
        	callback = function()
        		vim.highlight.on_yank({
        			higroup = "IncSearch",
        			timeout = 40,
        		})
        	end,
        })

        vim.g.netrw_browse_split = 0
        vim.g.netrw_banner = 0
        vim.g.netrw_winsize = 25


              -- REMAPS

              -- Use this one if NetRw is the file explorer being used
              --vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "NetRW" })
              -- Use this one if Oil is the file explorer being used
              vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

              vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
              vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
              vim.keymap.set("n", "J", "mzJ`z")
              vim.keymap.set("n", "<C-d>", "<C-d>zz")
              vim.keymap.set("n", "<C-u>", "<C-u>zz")
              vim.keymap.set("n", "n", "nzzzv")
              vim.keymap.set("n", "N", "Nzzzv")

              -- better up/down
              vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
              vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

              -- greatest remap ever
              vim.keymap.set("v", "p", '"_dP')

              -- next greatest remap ever : asbjornHaland
              vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
              vim.keymap.set("n", "<leader>Y", [["+Y]])

              -- This is going to get me cancelled
              vim.keymap.set("i", "<C-c>", "<Esc>")

              vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
              vim.keymap.set("n", "Q", "<nop>")
              vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
              -- Using conform to format files
              -- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format File" })

              vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
              vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
              vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
              vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

              vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
              vim.keymap.set("n", "<leader>e", "<cmd>!chmod +x %<CR>", { silent = true })

              vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim<CR>")

              -- avoid typing W instead of w to save the file
              vim.cmd("cabbrev W w")
              -- avoid typing Q instead of q to quit the file
              vim.cmd("cabbrev Q q")

              vim.keymap.set("n", "<leader><leader>", function()
                      vim.cmd("so")
                      end)

              -- This next keymaps are a courtesy of Jon Gjengset

              -- Jump to start and end of line using the home row keys
              vim.keymap.set("", "H", "^")
              vim.keymap.set("", "L", "$")

              -- handy keymap for replacing up to next _ (like in variable names)
              vim.keymap.set("n", "<leader>m", "ct_")
              -- handy keymap for deleting up to next _ (like in variable names)
              vim.keymap.set("n", "<leader>M", "dt_")

              -- always center search results
              vim.keymap.set("n", "n", "nzz", { silent = true })
              vim.keymap.set("n", "N", "Nzz", { silent = true })

              -- better indenting
              vim.keymap.set("v", "<", "<gv")
              vim.keymap.set("v", ">", ">gv")
      '';
      plugins =
        commonPlugins
        ++ gitPlugins;
    };
    # 2 tab size file types
    home.file."./.config/nvim/after/ftplugin/nix.lua".text = ''
      vim.opt.shiftwidth = 2
    '';

    home.packages = personalPackages;
  };
}
