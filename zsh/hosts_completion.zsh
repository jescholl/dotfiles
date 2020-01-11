_hosts () {
  builtin autoload -XUz
  _cache_hosts+=($(lshost))
	_wanted hosts expl host compadd -M 'm:{a-zA-Z}={A-Za-z} r:|.=* r:|=*' -a "$@" - _cache_hosts
}
