# One shared provider cache for every Terragrunt unit and worktree, instead of a
# full copy of each provider under every unit's .terragrunt-cache. Terragrunt runs
# a local cache server, so this is safe for parallel `run --all`, unlike
# Terraform's own plugin_cache_dir. Cache: ~/Library/Caches/terragrunt/providers.
export TG_PROVIDER_CACHE=1
