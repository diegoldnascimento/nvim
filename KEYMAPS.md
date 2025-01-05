## Basic Commands

| Key          | Description        | Mode |
| ------------ | ------------------ | ---- |
| `<C-s>`      | Save               | n    |
| `<C-q>`      | Save and Quit      | n    |
| `<leader>vv` | Split vertically   | n    |
| `<leader>vh` | Split horitonzally | n    |

## Navigation

| Key     | Description       | Mode |
| ------- | ----------------- | ---- |
| `<C-j>` | Move cursor down  | n    |
| `<C-h>` | Move cursor left  | n    |
| `<C-k>` | Move cursor up    | n    |
| `<C-l>` | Move cursor right | n    |

## Telescope

| Key          | Description                              | Mode |
| ------------ | ---------------------------------------- | ---- |
| `<Leader>fg` | Telescope Live Grep                      | n    |
| `<Leader>fG` | Telescope Live Grep Current Working File | n    |
| `<Leader>fh` | Telescope Help Tags                      | n    |
| `<Leader>fb` | Telescope File Browser                   | n    |
| `<Leader>fp` | Telescope Buffers                        | n    |
| `<Leader>fo` | Telescope Old Files                      | n    |
| `<Leader>fw` | Telescope Live Grep under current word   | n    |

## LSP

| Key  | Description                       | Mode |
| ---- | --------------------------------- | ---- |
| `gD` | Go to definition                  | n,v  |
| `gd` | Show LSP references               | n,v  |
| `gr` | Show references                   | n,v  |
| `[e` | Go to previous error diagnostic   | n,v  |
| `]e` | Go to next error diagnostic       | n,v  |
| `[w` | Go to previous warning diagnostic | n,v  |
| `]w` | Go to next warning diagnostic     | n,v  |
| `[d` | Go to previous diagnostic         | n,v  |
| `]d` | Go to next diagnostic             | n,v  |
| `ga` | Show code actions preview         | n,v  |
| `K`  | Show hover documentation          | n,v  |
| `gk` | Show hover lsp signature help     | n,v  |
| `gx` | Show workspace diagnostics        | n,v  |
| `X`  | Show line diagnostic              | n,v  |

## Git

| Key          | Description      | Mode |
| ------------ | ---------------- | ---- |
| `<Leader>gp` | Preview Git Hunk | n,v  |

## Git UI

| Key          | Description         | Mode |
| ------------ | ------------------- | ---- |
| `<Leader>lg` | Open the Lazygit UI | n,v  |

## Rest

| Key          | Description                      | Mode |
| ------------ | -------------------------------- | ---- |
| `<Leader>fr` | Run the request under the cursor | n    |
| `<Leader>fl` | Re-run the last request          | n    |

## Replacer

| Key          | Description                     | Mode |
| ------------ | ------------------------------- | ---- |
| `<Leader>fr` | Open the Renamer window         | n    |
| `<Leader>fR` | Save the Renamer window session | n    |

## Formatter

| Key     | Description | Mode |
| ------- | ----------- | ---- |
| `<C-f>` | Format      | n    |

## Flash

| Key   | Description         | Mode      |
| ----- | ------------------- | --------- |
| s     | Flash               | n, x, o   |
| S     | Flash Treesitter    | n, o, x   |
| r     | Remote Flash        | o         |
| R     | Treesitter Search   | o, x      |
| <c-s> | Toggle Flash Search | c into mr |

## Neotest

| Key          | Description         | Mode |
| ------------ | ------------------- | ---- |
| `<leader>tt` | Run File            | n    |
| `<leader>tT` | Run All Test Files  | n    |
| `<leader>tr` | Run Nearest         | n    |
| `<leader>ts` | Toggle Summary      | n    |
| `<leader>to` | Show Output         | n    |
| `<leader>tO` | Toggle Output Panel | n    |
| `<leader>tS` | Stop                | n    |

## Visual Multi Line

| Key     | Description                    | Mode |
| ------- | ------------------------------ | ---- |
| `<C-d>` | Select multi line under cursor | n    |

## Rest

| Key          | Description                  | Mode |
| ------------ | ---------------------------- | ---- |
| `<Leader>rr` | Run Rest command             | n    |
| `<Leader>rl` | Re-run the last rest command | n    |

## Trouble

| Key          | Description                          | Mode |
| ------------ | ------------------------------------ | ---- |
| `<Leader>xx` | Trouble Toggle                       | n    |
| `<Leader>xw` | Trouble Toggle Workspace Diagnostics | n    |
| `<Leader>xw` | Trouble Toggle Document Diagnostics  | n    |
| `<Leader>xq` | Trouble Toggle Quick Fix             | n    |
| `<Leader>xl` | Trouble Toggle Loclist               | n    |

## Todo Comments

| Key          | Description                 | Mode |
| ------------ | --------------------------- | ---- |
| `<leader>ft` | Open todo list in Telescope | n,v  |
| `[t`         | Next todo comment           | n    |
| `]t`         | Previous todo comment       | n    |

## Markdown

| Key          | Description          | Mode |
| ------------ | -------------------- | ---- |
| `<leader>mp` | Preview the Markdown | n,v  |

## Bufferline

| Key     | Description             | Mode |
| ------- | ----------------------- | ---- |
| `<S-h>` | Go to previous buffer   | n,v  |
| `<S-l>` | Go to next buffer       | n,v  |
| `[b`    | Go to previous buffer   | n,v  |
| `]b`    | Go to next buffer       | n,v  |
| `[[b`   | Move to previous buffer | n,v  |
| `]]b`   | Move to next buffer     | n,v  |
| `]B`    | Go to Last Buffer       | n,v  |
| `[B`    | Go to First Buffer      | n,v  |

## Yanky

| Key | Description                         | Mode |
| --- | ----------------------------------- | ---- |
| y   | Yank text                           | n, x |
| P   | Put yanked text after cursor        | n, x |
| p   | Put yanked text before cursor       | n, x |
| [y  | Cycle forward through yank history  |      |
| ]y  | Cycle backward through yank history |      |

## Refactoring

| Key           | Description              | Mode |
| ------------- | ------------------------ | ---- |
| `<leader>re`  | Extract Function         | x    |
| `<leader>rf`  | Extract Function To File | x    |
| `<leader>rv`  | Extract Variable         | x    |
| `<leader>rI`  | Inline Function          | n    |
| `<leader>ri`  | Inline Variable          | n, x |
| `<leader>rb`  | Extract Block            | n    |
| `<leader>rbf` | Extract Block To File    | n    |
| `<leader>rr`  | Refactor                 | n, x |
