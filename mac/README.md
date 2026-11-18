# Terminal no Mac

Passo a passo para deixar um Mac novo com o terminal assim:

```
╭─eduardovscruuz in /Volumes/SSD/eduardovscruuz/repos/pessoal/terminal-themes on main ✔
╰─±
```

Isso inclui as cores Dracula, a fonte FiraCode e o texto sem serrilhado.

| Arquivo | O que guarda |
|---|---|
| `eduardo.zsh-theme` | O prompt e a paleta de cores (fundo, texto e as 16 cores). Funciona em qualquer terminal que rode zsh. |
| `iterm2.profile.json` | O que só o iTerm2 controla: a fonte, o tamanho e o ajuste do serrilhado. Também traz a paleta. |

O tema é lido **direto do repo**, por um atalho. Se você mudar o `eduardo.zsh-theme` aqui, a mudança já vale no terminal. Depois, basta fazer commit.

---

## 1. Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

No fim, o instalador mostra dois comandos para colocar o `brew` no PATH. Rode os dois.

## 2. iTerm2

```sh
brew install --cask iterm2
```

## 3. Fonte FiraCode Nerd Font

```sh
brew install --cask font-fira-code-nerd-font
```

No iTerm2, ela aparece como **FiraCode Nerd Font Mono**. O perfil do passo 8 já usa essa fonte, no peso Medium (`FiraCodeNFM-Med`).

## 4. oh-my-zsh e os dois plugins

```sh
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

O `RUNZSH=no` evita que o instalador abra um shell novo no fim. Sem ele, os comandos de baixo ficariam parados. Depois, instale os plugins:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- **zsh-autosuggestions:** sugere em cinza o resto do comando, a partir do histórico. A seta → aceita a sugestão.
- **zsh-syntax-highlighting:** colore o comando enquanto você digita.

## 5. Clonar este repo

O caminho padrão é `/Volumes/SSD/eduardovscruuz/repos/pessoal/terminal-themes`. É a mesma árvore do Windows, onde o repo fica em `D:\ecruz\repos\pessoal\terminal-themes`. Se quiser outro caminho, troque o `REPO` aqui e no passo 6.

```sh
REPO=/Volumes/SSD/eduardovscruuz/repos/pessoal/terminal-themes
mkdir -p "$(dirname "$REPO")"
git clone https://github.com/eduardovscruuz/terminal-themes.git "$REPO"
```

Se o repo ficar num disco externo, o terminal só acha o tema com o disco montado (veja "Se algo der errado").

## 6. Ligar o tema ao oh-my-zsh

```sh
REPO=/Volumes/SSD/eduardovscruuz/repos/pessoal/terminal-themes
ln -sf "$REPO/mac/eduardo.zsh-theme" ~/.oh-my-zsh/custom/themes/eduardo.zsh-theme
```

Para conferir, rode `readlink ~/.oh-my-zsh/custom/themes/eduardo.zsh-theme`. Ele deve mostrar o caminho do repo.

## 7. Ajustar o `~/.zshrc`

No `~/.zshrc` que o oh-my-zsh criou, troque estas duas linhas:

```sh
ZSH_THEME="eduardo"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
```

## 8. Perfil do iTerm2

1. Abra o iTerm2 → **Settings** (⌘,) → **Profiles**.
2. Em **Other Actions…**, escolha **Import JSON Profiles…** e selecione `mac/iterm2.profile.json` deste repo.
3. Selecione o perfil **Terminal** que apareceu. Em **Other Actions…**, escolha **Set as Default**.
4. Apague o perfil **Default** com o botão `−`, para ficar um perfil só.
5. Feche e abra o iTerm2.

## 9. Conferir

Abra uma aba nova e veja se está tudo assim:

- **Fora de um repo:** `╭─eduardovscruuz in ~` e, na linha de baixo, `╰─○`.
- **Dentro de um repo:** `on <branch> ✔`, ou `✘` se houver alteração, e `╰─±` na linha de baixo.
- **Cores:** nome em rosa, caminho em ciano e negrito, branch em roxo e fundo azul bem escuro (`#0B1119`).
- **Fonte:** FiraCode, com as ligaduras. Digitar `=>` e `!=` vira um símbolo só.

---

## O que vem de onde

- **O prompt e a paleta** estão no `eduardo.zsh-theme`. A paleta vai para o terminal por códigos de cor (OSC) quando o shell abre. Por isso o Terminal.app, o Ghostty e outros também ficam com as cores, se entenderem esses códigos.
- **A fonte, o tamanho e o serrilhado** só o aplicativo do terminal controla. No iTerm2, eles vêm do `iterm2.profile.json`.
  - O serrilhado é controlado pela opção "Use thin strokes", que fica em **Retina only**. Em monitor que não é Retina, o traço fino deixa a letra serrilhada.
- **Para mudar uma cor**, edite a tabela `EDUARDO_PALETA`, que fica no topo do `eduardo.zsh-theme`, ou as variáveis `c_*` do prompt. Depois rode `source ~/.zshrc`.

## Se algo der errado

- **Aparece `[oh-my-zsh] theme 'eduardo' not found`:** o atalho do passo 6 está quebrado. Ou o repo mudou de lugar, e aí é refazer o passo 6 com o caminho novo, ou ele está num disco externo que não está montado, e aí é montar o disco e abrir um terminal novo.
- **As letras aparecem como quadradinhos ou `?`:** falta a fonte do passo 3, ou o perfil não está usando a fonte. Confira em Settings → Profiles → Terminal → Text → Font.
- **O perfil importado não virou o padrão:** refaça os itens 3 e 4 do passo 8. A estrela ao lado do nome marca o perfil padrão.
- **As cores mudam, mas o fundo continua o do perfil:** é o comportamento esperado em terminais que ignoram os códigos de cor. No iTerm2, o perfil já tem o mesmo fundo.
