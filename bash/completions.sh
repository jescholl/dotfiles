# shellcheck disable=SC2148
aws_completer_path="$(command -v aws_completer)"
if [ -x "$aws_completer_path" ]; then
  complete -C "$aws_completer_path" aws
fi

self_completing_tools=(consul vault terraform)
for tool_name in "${self_completing_tools[@]}"; do
  tool_path="$(command -v "$tool_name")"
  if [ -x "$tool_path" ]; then
    complete -C "$tool_path" "$tool_name"
  fi
done
