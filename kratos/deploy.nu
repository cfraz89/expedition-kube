#!/usr/bin/env nu
def main [
  command: string, #Helm command to run (install | upgrade)
  toEnv: string, #Helm command to run ("local" | "production")
  --load-secrets #Load secrets for env into cluster before deploying
] {
  if $command not-in ["install", "upgrade"] {
    error make {msg: "Command must be one of [install, upgrade]"}
  }
  if $toEnv not-in ["local", "production"] {
    ecbo $toEnv
    error make {msg: "Env must be one of [local, production]"}
  }
  if $load_secrets {
    kubectl apply -f $"env/($toEnv)/secrets.yaml"
  }
  helm $command -f values.yaml -f $"env/($toEnv)/values.yaml" expedition-kratos ory/kratos
}