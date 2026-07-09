# Neovim Cheatsheet

Leader = Space

## LSP — Code Navigation

| Key       | Action                          |
|-----------|---------------------------------|
| `gd`      | Go to definition                |
| `gr`      | Find all references             |
| `gi`      | Go to implementation            |
| `gy`      | Go to type definition           |
| `gD`      | Go to declaration               |
| `K`       | Hover docs / type info          |
| `<C-o>`   | Jump back (after gd/gr/etc)     |
| `<C-i>`   | Jump forward                    |
| `[d`      | Previous diagnostic (error/warn)|
| `]d`      | Next diagnostic                 |

## LSP — Refactoring

| Key            | Action              |
|----------------|---------------------|
| `<leader>rn`   | Rename symbol       |
| `<leader>ca`   | Code action (fixes) |

## Completion (insert mode)

| Key         | Action                    |
|-------------|---------------------------|
| `<C-Space>` | Trigger completion        |
| `<Tab>`     | Next suggestion           |
| `<S-Tab>`   | Previous suggestion       |
| `<CR>`      | Confirm selection         |
| `<C-d>`     | Scroll docs down          |
| `<C-u>`     | Scroll docs up            |

## Telescope — Find

| Key            | Action            |
|----------------|-------------------|
| `<leader>ff`   | Find files        |
| `<leader>fg`   | Live grep         |
| `<leader>fb`   | Buffers           |
| `<leader>fh`   | Help tags         |
| `<leader>fs`   | Document symbols  |

## File Tree (Neo-tree)

| Key            | Action            |
|----------------|-------------------|
| `<leader>tt`   | Toggle file tree  |

## Git

| Key            | Action             |
|----------------|--------------------|
| `<leader>td`   | Toggle diff view   |
| `<leader>th`   | Toggle file history|
| `<leader>tb`   | Toggle git blame   |

## General

| Key            | Action                     |
|----------------|----------------------------|
| `<leader>x`    | Close buffer               |
| `<leader>tw`   | Toggle whitespace chars    |
| `:LspInfo`     | Show LSP status for buffer |
| `:Mason`       | Manage LSP servers         |

## Brazil / Bemol Workflow

```bash
cd src/YourPackage
bemol              # generate LSP project files (run once or with --watch)
nvim .             # LSP will find .bemol/ and understand the project
```
