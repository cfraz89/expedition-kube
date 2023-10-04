package kube

import (
	"encoding/yaml"
	"tool/cli"
	"tool/file"
	"tool/exec"
)

yamlConfig: yaml.Marshal(config)

command: {
	dump: task: print: cli.Print & {
		text: yamlConfig
	}
	"export-config": task: export: file.Create & {
		filename: "expedition-kratos-config.yaml"
		contents: yamlConfig
	}
	kube: task: exec.Run & {
		cmd:    "kubectl apply -f -"
		stdin:  yamlConfig
		stdout: string
	}
}
