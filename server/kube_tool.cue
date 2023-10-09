package server

import (
	"encoding/yaml"
	"tool/cli"
	"tool/file"
	"tool/exec"
)

secrets:    string @tag(secrets)
yamlSecret: yaml.Marshal(secret[secrets])

command: {
	"dump": task: print: cli.Print & {
		text: yamlSecret
	}
	"export": task: export: file.Create & {
		filename: "expedition-server-secret.yaml"
		contents: yamlSecret
	}
	"apply": task: exec.Run & {
		cmd:    "kubectl apply -f -"
		stdin:  yamlSecret
		stdout: string
	}
}
