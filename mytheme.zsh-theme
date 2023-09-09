local return_code="%(?..%F{red}%? ✗%f)"
local user_host='%F{010}%n%f'
local current_dir='%F{004}%~%f'
local git_branch='%F{cyan}$(git_prompt_info)%f'

NL=$'\n'
PROMPT="%B${user_host} ${current_dir}$NL${git_branch} $%b "
RPROMPT='${return_code} %T %D'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}✔%f"
