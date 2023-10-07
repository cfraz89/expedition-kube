package kratos

import (
	"encoding/yaml"
	"tool/cli"
	"tool/file"
	"tool/exec"
)

env:        string @tag(env)
secrets:    string @tag(secrets)
yamlConfig: yaml.Marshal(config[env])
yamlSecret: yaml.Marshal(secret[secrets])
allYaml:    yamlConfig + "\n---\n" + yamlSecret

command: {
	"dump-config": task: print: cli.Print & {
		text: yamlConfig
	}
	"dump-secret": task: print: cli.Print & {
		text: yamlSecret
	}
	"dump": task: print: cli.Print & {
		text: allYaml
	}
	"export-config": task: export: file.Create & {
		filename: "expedition-kratos-config.yaml"
		contents: yamlConfig
	}
	"export-secret": task: export: file.Create & {
		filename: "expedition-kratos-secret.yaml"
		contents: yamlSecret
	}
	"export": task: export: file.Create & {
		filename: "expedition-kratos.yaml"
		contents: allYaml
	}
	"apply-config": task: exec.Run & {
		cmd:    "kubectl apply -f -"
		stdin:  yamlConfig
		stdout: string
	}
	"apply-secret": task: exec.Run & {
		cmd:    "kubectl apply -f -"
		stdin:  yamlSecret
		stdout: string
	}
	"apply": task: exec.Run & {
		cmd:    "kubectl apply -f -"
		stdin:  allYaml
		stdout: string
	}
}
