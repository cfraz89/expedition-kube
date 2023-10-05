package base

import (
	"encoding/yaml"
	"encoding/json"
)

#ConfigMap: {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name: "expedition-kratos-config"
	#kratos:          #KratosConfig
	#identity_schema: #IdentitySchemaConfig
	data: {
		"kratos.yaml":           yaml.Marshal(#kratos)
		"identity.schema.json":  json.Marshal(#identity_schema)
		"google-mapper.jsonnet": #GoogleMapperConfig
	}
}
