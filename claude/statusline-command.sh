#!/bin/sh
# Claude Code statusLine script
#
# First segment renders using the *actual* prompt code from the dotfiles repo
# (zsh/prompt.zsh + git/environment.zsh's gitprompt plugin) instead of
# reimplementing it, so it stays byte-for-byte identical to the real prompt
# even if the theme changes later.
#
# Second segment shows info the shell prompt has no concept of: the active
# model, and context-window usage as both a token ratio (e.g. "35k/200k")
# and a percentage.

DOTFILES_ROOT="/Users/jscholl/home/dotfiles"

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

prompt_seg=$(cd "$cwd" 2>/dev/null && DOTFILES_ROOT="$DOTFILES_ROOT" zsh -fc '
    export DOTFILES_SCRATCH="$DOTFILES_ROOT/.__dotfiles_scratch__"
    source "$DOTFILES_ROOT/zsh/prompt.zsh"      >/dev/null 2>&1
    source "$DOTFILES_ROOT/git/environment.zsh" >/dev/null 2>&1

    time_seg=$(print -nP "$(prompt_clock)")
    dir_seg=$(print -nP "$(directory_name)")

    git_seg=""
    git_raw=$(_zsh_git_prompt_git_status 2>/dev/null)
    [ -n "$git_raw" ] && git_seg=" $(print -nP "$git_raw")"

    print -nr -- "${time_seg} ${dir_seg}${git_seg}"
')

RESET='\033[0m'
MAGENTA='\033[0;35m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GRAY238='\033[38;5;238m'

model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.total_input_tokens')
size=$(echo "$input" | jq -r '.context_window.context_window_size')
pct=$(echo "$input" | jq -r '.context_window.used_percentage')
session_id=$(echo "$input" | jq -r '.session_id')

# Round token counts to the nearest thousand, e.g. 103139 -> "103k"
to_k() {
    awk -v n="$1" 'BEGIN { printf "%dk", int(n / 1000 + 0.5) }'
}

# Round a percentage to the nearest integer, e.g. 55.00000000000001 -> "55"
round_pct() {
    awk -v n="$1" 'BEGIN { printf "%d", int(n + 0.5) }'
}

pct=$(round_pct "$pct")

five_hr_pct=$(echo "$input"    | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hr_reset=$(echo "$input"  | jq -r '.rate_limits.five_hour.resets_at       // empty')
seven_day_pct=$(echo "$input"  | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_reset=$(echo "$input"| jq -r '.rate_limits.seven_day.resets_at       // empty')

[ -n "$five_hr_pct" ]  && five_hr_pct=$(round_pct "$five_hr_pct")
[ -n "$seven_day_pct" ] && seven_day_pct=$(round_pct "$seven_day_pct")

# Reset time as an absolute local date/time (e.g. "Sat 3:45PM") rather than a
# countdown, so a stale statusline render is still an accurate reset time.
fmt_reset() {
    date -r "$1" "+%a %-I:%M%p"
}

if [ -n "$five_hr_pct" ] && [ -n "$five_hr_reset" ]; then
    five_str=$(fmt_reset "$five_hr_reset")
    quota_seg="${five_hr_pct}% · ${five_str}"
    if [ -n "$seven_day_pct" ] && [ -n "$seven_day_reset" ]; then
        seven_str=$(fmt_reset "$seven_day_reset")
        quota_seg="${quota_seg} [${seven_day_pct}% · ${seven_str}]"
    fi
    printf "%s  ${MAGENTA}%s${RESET}  ${YELLOW}%s/%s (%s%%)${RESET}  ${CYAN}%s${RESET}  ${GRAY238}(%s)${RESET}" \
        "$prompt_seg" "$model" "$(to_k "$used")" "$(to_k "$size")" "$pct" \
        "$quota_seg" "$session_id"
else
    printf "%s  ${MAGENTA}%s${RESET}  ${YELLOW}%s/%s (%s%%)${RESET}  ${GRAY238}(%s)${RESET}" \
        "$prompt_seg" "$model" "$(to_k "$used")" "$(to_k "$size")" "$pct" "$session_id"
fi
