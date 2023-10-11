package kratos

import (
	"encoding/yaml"
	"encoding/json"
	"expedition.com.au/kratos/schema"
)

config: [string]: schema.#ConfigMap

config: [string]: {
	_kratos:         schema.#KratosConfig
	_identitySchema: schema.#IdentitySchemaConfig
	_googleMapper:   schema.#GoogleMapperConfig
	data: {
		"kratos.yaml":           yaml.Marshal(_kratos)
		"identity.schema.json":  json.Marshal(_identitySchema)
		"google-mapper.jsonnet": _googleMapper
	}
}

secret: [string]: schema.#Secret

secret: [string]: {
	_oidcProviders: schema.#OidcProviders
	stringData: {
		"oidc-config-providers": json.Marshal([_oidcProviders.google])
	}
}
