package config

import (
	"encoding/yaml"
	"encoding/json"
	#Kratos "expedition.com.au/kratos-config/base/kratos:kratos"
	"expedition.com.au/kratos-config/base/identity-schema:identity_schema"
	"expedition.com.au/kratos-config/base/google-mapper:google_mapper"
)

#Config: {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name: "expedition-kratos-config"
	#kratos: #Kratos
	data: {
		"kratos.yaml":           yaml.Marshal(#kratos)
		"identity.schema.json":  json.Marshal(identity_schema)
		"google-mapper.jsonnet": google_mapper
	}
}
