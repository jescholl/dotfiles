tools_dir=${DOTFILES_SCRATCH}/tool_keeper
versions_file=${DOTFILES_SCRATCH}/tool_keeper_versions.zsh

test -d $tools_dir || mkdir -p $tools_dir
test -f $versions_file || touch $versions_file

assign_var() {
  # use weird bash indirection trick to assign variables dynamically
  local var_name=$1
  local value=$2
  read -r "$var_name" <<<"$value"
}

tool_path() {
  local tool_name=$1
  local version=$2
  echo ${tools_dir}/${tool_name}-${version}
}


any_existing_version() {
  local tool_name=$1
  local glob=(${~$(tool_path $tool_name "?*")}) 2> /dev/null
  local found_name=$(basename $glob[1])
  local version=${found_name##*-}
  echo $version
}

error() {
  echo $@ >&2
}

tool_version() {
  local tool_name=$1
  local version_var=TK_$(echo $tool_name | tr '[:lower:]' '[:upper:]')_VERSION
  local version=${(P)version_var}
  if [ -z "$version" ]; then
    version=${version:-$(any_existing_version $tool_name)} # use anything we have
    version=${version:-$(tool_keeper_${tool_name}_latest_version)} # we don't have anything, download the latest
    [ -z "${version}" ] && echo $0: $tool_name: Unable to determine version >&2 && return 4
    sed -i '' "/export ${version_var}=.*$/d" $versions_file # delete the line if it's there
    echo "export ${version_var}=$version" >> $versions_file # add it back
    assign_var $version_var $version
    export $version_var
  fi
  echo $version
}

run_tool() {
  local tool_name=$1; shift
  local opts=($@)
  local version=$(tool_version $tool_name)
  [ "$?" -eq 0 ] || return 1
  local version_path=$(tool_path $tool_name $version)
  if [[ ! -f $version_path || ! -x $version_path ]]; then
    tool_keeper_${tool_name}_install ${version}
  fi
  $version_path $opts
}
