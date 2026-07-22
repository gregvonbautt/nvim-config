## Personal nvim config

Leader key: `<Space>`

## Plugins

| Plugin | What it does |
|--------|--------------|
| catppuccin | Colorscheme |
| diffview.nvim | Side-by-side git diffs and file history |
| neo-tree.nvim | File tree browser (fullscreen, toggled on demand) |
| telescope.nvim | Fuzzy finder for files, grep, symbols, diagnostics |
| telescope-fzf-native | Faster sorting for Telescope (C extension) |
| gitsigns.nvim | Git change indicators in the gutter + blame |
| which-key.nvim | Shows available keybindings after pressing leader |
| lualine.nvim | Status line (shows relative file path) |
| markview.nvim | Renders markdown nicely in-buffer |
| mason.nvim | Installs and manages LSP servers |
| nvim-jdtls | Java LSP with multi-project workspace support |
| nvim-cmp | Autocompletion engine |
| LuaSnip | Snippet engine (required by nvim-cmp for LSP snippets) |

## Key Bindings

### LSP — Code Navigation (via Telescope popup)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find all references |
| `gi` | Go to implementation |
| `gD` | Go to type definition |
| `K` | Hover — show type signature and docs |
| `<C-o>` | Jump back (after any navigation) |
| `<C-i>` | Jump forward |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Show full diagnostic message |

### LSP — Refactoring

| Key | Action |
|-----|--------|
| `<leader>rn` | Rename symbol across project |
| `<leader>ca` | Code action (quick fixes, imports) |

### Completion (insert mode)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion menu |
| `<Tab>` | Next suggestion |
| `<S-Tab>` | Previous suggestion |
| `<CR>` | Confirm selection |
| `<C-d>` | Scroll docs down |
| `<C-u>` | Scroll docs up |

### Telescope — Find

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text across project) |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |
| `<leader>fs` | Document symbols (current file) |
| `<leader>fd` | Diagnostics (current file) |
| `<leader>fD` | Diagnostics (workspace) |
| `<C-p>` | Toggle preview pane (inside Telescope) |
| `<C-u>` | Scroll preview up (inside Telescope) |
| `<C-d>` | Scroll preview down (inside Telescope) |
| `<Esc>` | Close Telescope |

### File Tree (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle file tree (fullscreen) |

### Git

| Key | Action |
|-----|--------|
| `<leader>td` | Toggle diff view |
| `<leader>th` | Toggle file history (current file) |
| `<leader>tb` | Toggle git blame |

### General

| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlighting |
| `<leader>x` | Close current buffer |
| `<leader>tw` | Toggle whitespace characters |
| `:Mason` | Manage LSP servers |
| `:checkhealth vim.lsp` | Show LSP status |
| `:Lazy` | Manage plugins |

## Vim Essentials

### Moving around

| Key | Action |
|-----|--------|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` | Next word start |
| `b` | Previous word start |
| `e` | Next word end |
| `0` | Start of line |
| `$` | End of line |
| `^` | First non-blank character |
| `gg` | Top of file |
| `G` | Bottom of file |
| `{` | Previous blank line (paragraph up) |
| `}` | Next blank line (paragraph down) |
| `<C-d>` | Half page down |
| `<C-u>` | Half page up |
| `%` | Jump to matching bracket |
| `:<number>` | Go to line number |
| `<C-g>` | Show full file path |

### Searching

| Key | Action |
|-----|--------|
| `/text` | Search forward (case-insensitive by default) |
| `?text` | Search backward |
| `/Text` | Search case-sensitive (uppercase triggers exact match) |
| `/\ctext` | Force case-insensitive |
| `/\Ctext` | Force case-sensitive |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search for word under cursor |
| `<Esc>` | Clear search highlighting |

### Selecting (Visual mode)

| Key | Action |
|-----|--------|
| `v` | Start character selection |
| `V` | Select entire line |
| `<C-v>` | Block (column) selection |
| `vi{` | Select inside `{}` |
| `vi(` | Select inside `()` |
| `vi"` | Select inside quotes |
| `viw` | Select word |
| `vip` | Select paragraph |
| `o` | Jump to other end of selection |

### Copy / Paste (yank / put)

| Key | Action |
|-----|--------|
| `y` | Yank (copy) selection |
| `yy` | Yank entire line |
| `yw` | Yank word |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `d` | Delete (also copies to register) |
| `dd` | Delete line |
| `x` | Delete character |
| `"0p` | Paste from yank register (ignores deletes) |
| `"+y` | Copy to system clipboard |
| `"+p` | Paste from system clipboard |

### Editing

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `o` | New line below and insert |
| `O` | New line above and insert |
| `ciw` | Change (replace) word |
| `ci"` | Change inside quotes |
| `cc` | Change entire line |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last change |
| `>>` | Indent line |
| `<<` | Unindent line |

### Windows and Buffers

| Key | Action |
|-----|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `<C-w>s` | Split horizontal |
| `<C-w>v` | Split vertical |
| `<C-w>h/j/k/l` | Move between splits |
| `<C-w>q` | Close split |
