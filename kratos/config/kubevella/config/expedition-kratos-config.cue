package kube

import (
	"encoding/yaml"
	"encoding/json"
	"expedition.com.au/kratos-config/data/kratos:kratos"
	"expedition.com.au/kratos-config/data/identity-schema:identity_schema"
	"expedition.com.au/kratos-config/data/google-mapper:google_mapper"
)

config: {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name: "expedition-kratos-config"
	data: {
		"kratos.yaml":           yaml.Marshal(kratos)
		"identity.schema.json":  json.Marshal(identity_schema)
		"google-mapper.jsonnet": google_mapper
	}
}
