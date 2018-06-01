_hosts () {
	local expl _hosts tmp useip
	if ! zstyle -a ":completion:${curcontext}:hosts" hosts _hosts
	then
		if (( $+_cache_hosts == 0 ))
		then
			typeset -gUa _cache_hosts
			local ipstrip='[:blank:]#[^[:blank:]]#' 
			zstyle -t ":completion:${curcontext}:hosts" use-ip && useip=yes 
			[[ -n $useip ]] && ipstrip= 
			if (( ${+commands[getent]} ))
			then
				_cache_hosts=(${(s: :)${(ps:\t:)${(f)~~"$(_call_program hosts getent hosts 2>/dev/null)"}##${~ipstrip}}}) 
			else
				_cache_hosts=(${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##${~ipstrip}}}) 
				if (( ${+commands[ypcat]} )) && tmp=$(_call_program hosts ypcat hosts.byname 2>/dev/null) 
				then
					_cache_hosts+=(${=${(f)tmp}##${~ipstrip}}) 
				fi
			fi
			local khostfile host_dir exclude_hosts
			typeset -Ua khostfiles
			zstyle -a ":completion:${curcontext}:hosts" known-hosts-files khostfiles || khostfiles=(/etc/ssh/ssh_known_hosts ~/.ssh/known_hosts) 
			for host_dir in $COMPLETION_HOST_DIRS; do
			  if [[ -d $host_dir ]]; then
			    khosts=(${(s/,/j/,/u)${(f)"$(ls $host_dir)"}//(.(e|)yaml|.pp)/});
			    _cache_hosts+=($khosts)
			  fi
			done
			for khostfile in $khostfiles
			do
				if [[ -r $khostfile ]]
				then
					khosts=(${(s/,/j/,/u)${(f)"$(<$khostfile)"}%%[ |#]*}) 
					() {
						local host
						khosts=() 
						for host
						do
							if [[ $host == *[*?]* ]]
							then
								continue
							elif [[ $host =~ "\[(.*)\]:\d*" ]]
							then
								khosts+=$match 
							else
								khosts+=$host 
							fi
						done
					} "$khosts[@]"
					if [[ -z $useip ]]
					then
						khosts=(${${khosts:#(#s)[0-9]##.[0-9]##.[0-9]##.[0-9]##(#e)}:#(#s)[0-9a-f:]##(#e)}) 
					fi
					_cache_hosts+=($khosts) 
				fi
			done
		fi
		_hosts=("$_cache_hosts[@]") 
	fi
	_wanted hosts expl host compadd -M 'm:{a-zA-Z}={A-Za-z} r:|.=* r:|=*' -a "$@" - _hosts
}
