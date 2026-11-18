# terminal-themes

Meu terminal, igual no Mac e no Windows:

```
╭─eduardovscruuz in /Volumes/SSD/eduardovscruuz/repos/pessoal/terminal-themes on main ✔
╰─±
```

- **Prompt:** em duas linhas. O comando é digitado na linha de baixo.
- **Branch:** `✔` quando o repo está limpo e `✘` quando há alteração. Fora de um repo, o `±` vira `○`.
- **Cores:** paleta Dracula. Nome `#FF79C6`, caminho `#8BE9FD`, branch `#BD93F9`, `in`/`on` `#6272A4`, `✘` `#F1FA8C`, `✔` `#50FA7B` e fundo `#0B1119`.
- **Fonte:** FiraCode Nerd Font Mono Medium. Tamanho 12 no iTerm2 e 11 no Windows Terminal, que dão um tamanho parecido na tela.

## Instalação

- **Mac** (zsh + oh-my-zsh + iTerm2): [`mac/README.md`](mac/README.md)
- **Windows** (PowerShell 7 + oh-my-posh + Windows Terminal): [`windows/README.md`](windows/README.md)

## Regra

O tema é editado **neste repo**. As máquinas leem os arquivos daqui: no Mac por um atalho, e no Windows pelo `--config` do oh-my-posh. Para mudar alguma coisa:

1. Edite o arquivo de tema.
2. Abra um terminal novo e confira.
3. Faça a mesma mudança no tema do outro sistema.
4. Faça o commit.

| | Mac | Windows |
|---|---|---|
| Prompt | `mac/eduardo.zsh-theme` | `windows/eduardo.oh-my-posh.json` |
| Paleta | dentro do `eduardo.zsh-theme` (e no perfil do iTerm2) | `windows/windows-terminal.settings.json` |
| Fonte e serrilhado | `mac/iterm2.profile.json` | `windows/windows-terminal.settings.json` |
