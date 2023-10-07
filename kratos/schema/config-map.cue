package schema

#ConfigMap: {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name: "expedition-kratos-config"
	data: {
		"kratos.yaml":           string
		"identity.schema.json":  string
		"google-mapper.jsonnet": string
	}
}
