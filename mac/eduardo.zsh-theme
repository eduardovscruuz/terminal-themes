# eduardo.zsh-theme
# Aparência completa do terminal no zsh: paleta (fundo, texto, 16 cores) + prompt.
# Baseado no "fino", mais enxuto. Cores do Dracula, as mesmas do Windows.
# Fonte e serrilhado não cabem aqui: são do aplicativo do terminal.

# ─── Paleta ────────────────────────────────────────────────────────────────
# Enviada ao terminal ao abrir o shell (códigos OSC 4/10/11/12/17).
# Funciona no iTerm2, Windows Terminal, Ghostty, WezTerm, kitty...; quem não entende ignora.
typeset -gA EDUARDO_PALETA=(
  fundo     0B1119   texto     F8F8F2   cursor    F8F8F2   selecao   44475A
  0  21222C   1  FF4444   2  3AFF6C   3  F1FA8C   4  B37DFF   5  F85FB6   6  79E6FF   7  F8F8F2
  8  6C717D   9  FF5D5D  10  58FF88  11  FFFFA5  12  D6ACFF  13  FF82DA  14  A4FFFF  15  FFFFFF
)

function eduardo_aplicar_paleta {
  [[ -o interactive && -t 1 ]] || return
  local h i
  _osc_cor() { h=$1; print -n "${2}rgb:${h[1,2]}/${h[3,4]}/${h[5,6]}\a" }
  for i in {0..15}; do _osc_cor $EDUARDO_PALETA[$i] "\e]4;$i;"; done
  _osc_cor $EDUARDO_PALETA[texto]   "\e]10;"
  _osc_cor $EDUARDO_PALETA[fundo]   "\e]11;"
  _osc_cor $EDUARDO_PALETA[cursor]  "\e]12;"
  _osc_cor $EDUARDO_PALETA[selecao] "\e]17;"
  unfunction _osc_cor
}
eduardo_aplicar_paleta

# ─── Prompt ────────────────────────────────────────────────────────────────
# ╭─eduardovscruuz in ~/pasta on branch ✘
# ╰─±
# Nome fixo; o usuário do macOS continua "eduardocruz".

local c_texto="%F{#F8F8F2}"   # ╭─ ╰─ ± ○
local c_nome="%F{#FF79C6}"    # nome (rosa)
local c_cinza="%F{#6272A4}"   # "in", "on"
local c_pasta="%F{#8BE9FD}"   # caminho (ciano)
local c_branch="%F{#BD93F9}"  # branch (roxo)
local c_sujo="%F{#F1FA8C}"    # ✘ (amarelo = alteração, como no Windows)
local c_limpo="%F{#50FA7B}"   # ✔ (verde)

function prompt_char {
  command git branch &>/dev/null && echo "±" || echo '○'
}

function virtualenv_prompt_info {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo " ${c_cinza}using «${VIRTUAL_ENV:t}»%f"
}
export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT="${c_texto}╭─${c_nome}eduardovscruuz ${c_cinza}in %B${c_pasta}%~%b"'$(git_prompt_info)$(virtualenv_prompt_info)'"
${c_texto}╰─"'$(prompt_char)'"%f "

ZSH_THEME_GIT_PROMPT_PREFIX=" ${c_cinza}on ${c_branch}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${c_sujo}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" ${c_limpo}✔"
