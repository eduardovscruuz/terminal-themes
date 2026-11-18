# Terminal no Windows

> Conferido no Windows em: 18/11/2026 (Windows 11, PowerShell 7.7.0, oh-my-posh 33.0.0, Windows Terminal 1.25)

Passo a passo para deixar um PC novo com o mesmo terminal do Mac:

```
╭─eduardovscruuz in D:\ecruz\repos\projetos-pessoais\terminal-themes on main ✔
╰─±
```

Isso inclui as cores Dracula e a fonte FiraCode.

| Arquivo | O que guarda |
|---|---|
| `eduardo.oh-my-posh.json` | O prompt (formato e cores). É o mesmo visual do `mac/eduardo.zsh-theme`. |
| `windows-terminal.settings.json` | Só o que o Windows Terminal controla: a paleta "Dracula VS Code" e a fonte. |

O PowerShell lê o tema **direto do repo**. Se você mudar o `eduardo.oh-my-posh.json` aqui, a mudança vale no próximo terminal que abrir. Depois, basta fazer commit.

---

## 1. PowerShell 7 e Git

```powershell
winget install --id Microsoft.PowerShell -e
winget install --id Git.Git -e
```

O PowerShell 7 é o `pwsh`. Ele não é o "Windows PowerShell" azul que já vem no Windows.

## 2. Windows Terminal

No Windows 11 ele já vem instalado. Se não estiver:

```powershell
winget install --id Microsoft.WindowsTerminal -e
```

## 3. oh-my-posh

```powershell
winget install --id JanDeDobbeleer.OhMyPosh -e
```

Feche e abra o terminal, para o comando `oh-my-posh` passar a existir.

## 4. Fonte FiraCode Nerd Font

```powershell
oh-my-posh font install FiraCode
```

Rode num terminal **normal**, não como administrador. Assim a fonte fica só para o seu usuário e não pede UAC. O oh-my-posh 33 não tem mais a opção `--user`, que dá erro. No Windows Terminal, a fonte aparece como **FiraCode Nerd Font Mono**.

## 5. Clonar este repo

```powershell
git clone https://github.com/eduardovscruuz/terminal-themes.git "D:\ecruz\repos\projetos-pessoais\terminal-themes"
```

## 6. Carregar o tema no PowerShell

Faça este passo **no PowerShell 7**. Abra o Windows Terminal, crie uma aba nova pela seta ˅ e escolha **PowerShell**, a opção de ícone preto. Para confirmar:

```powershell
$PSVersionTable.PSVersion
```

O resultado tem que começar com `7`. No Windows PowerShell 5.1, que é o azul, o `$PROFILE` é outro arquivo, e o tema não aparece no PowerShell 7.

Abra o perfil. Se ele ainda não existir, o primeiro comando cria o arquivo:

```powershell
if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Force $PROFILE | Out-Null }
notepad $PROFILE
```

Coloque esta linha no perfil. Se já houver outra linha com `oh-my-posh init`, troque por esta:

```powershell
oh-my-posh init pwsh --config "D:\ecruz\repos\projetos-pessoais\terminal-themes\windows\eduardo.oh-my-posh.json" | Invoke-Expression
```

Use sempre `$PROFILE` e o caminho entre aspas. Às vezes o perfil fica no OneDrive ou numa pasta com espaço, como `Documentos\PowerShell`, e um caminho digitado à mão quebra.

## 7. Windows Terminal: paleta e fonte

1. No Windows Terminal, vá em **Configurações** (Ctrl+,) e clique em **Abrir arquivo JSON**, no canto inferior esquerdo.
2. No arquivo `windows-terminal.settings.json` deste repo, copie o item de dentro de `"schemes"` e cole na lista `"schemes"` do arquivo aberto.
3. Copie o conteúdo de `"profiles" → "defaults"` e coloque em `"profiles" → "defaults"` do arquivo aberto. Junte com o que já estiver lá.
4. Salve. Depois, em **Configurações → Inicialização → Perfil padrão**, escolha **PowerShell** (o 7, com o ícone preto).

## 8. Conferir

Abra uma janela **nova** do Windows Terminal e veja se está tudo assim:

- **Fora de um repo:** `╭─eduardovscruuz in ~` e, na linha de baixo, `╰─○`.
- **Dentro de um repo:** `on <branch> ✔`, ou `✘` se houver alteração, e `╰─±` na linha de baixo.
- **Cores:** nome em rosa, caminho em ciano e negrito, branch em roxo e fundo azul bem escuro (`#0B1119`).
- **Fonte:** FiraCode.

Para testar sem abrir um terminal novo:

```powershell
oh-my-posh print primary --config "D:\ecruz\repos\projetos-pessoais\terminal-themes\windows\eduardo.oh-my-posh.json" --shell pwsh
```

**Pegadinha:** num terminal que já estava aberto antes da troca, a variável `POSH_CONFIG` da sessão vence o `--config` do `print`. Para testar, abra um terminal novo.

---

## O que vem de onde

- **O prompt** está no `eduardo.oh-my-posh.json`.
- **A paleta e a fonte** ficam no `settings.json` do Windows Terminal. É por isso que existe o passo 7. O oh-my-posh não consegue mudar o fundo nem a fonte do terminal.
- **Para mudar uma cor do prompt**, edite as cores `#RRGGBB` no `eduardo.oh-my-posh.json` e abra um terminal novo. Para manter as duas máquinas iguais, faça a mesma troca no `mac/eduardo.zsh-theme`.

## Se algo der errado

- **Aparece `CONFIG NOT FOUND` ou o prompt padrão do oh-my-posh:** o caminho do `--config` no `$PROFILE` não bate com o lugar do repo. Confira com `Test-Path "D:\ecruz\repos\projetos-pessoais\terminal-themes\windows\eduardo.oh-my-posh.json"`.
- **As letras aparecem como quadradinhos:** a fonte do passo 4 não foi instalada, ou o nome em `"face"` não bate. Confira o nome exato em **Configurações do Windows → Personalização → Fontes** e procure por "FiraCode".
- **No terminal integrado do VS Code, as letras aparecem como quadradinhos:** ele também precisa da fonte. No `settings.json` do VS Code, coloque `"terminal.integrated.fontFamily": "FiraCode Nerd Font Mono"`.
