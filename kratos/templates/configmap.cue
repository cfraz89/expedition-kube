package templates

import (
	"encoding/yaml"
	corev1 "k8s.io/api/core/v1"
)

#ConfigMap: corev1.#ConfigMap & {
	_config:    #Config
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: {
		name:      _config.metadata.name
		namespace: _config.metadata.namespace
		labels:    _config.metadata.labels
		if _config.metadata.annotations != _|_ {
			annotations: _config.metadata.annotations
		}
	}
	immutable: true
	data: {
		"kratos.yaml":          yaml.Marshal(_config.kratos.config)
		"identity.schema.json": yaml.Marshal({
			"$id":     "https://schemas.ory.sh/presets/kratos/quickstart/email-password/identity.schema.json"
			"$schema": "http://json-schema.org/draft-07/schema#"
			"title":   "Person"
			"type":    "object"
			"properties": {
				"traits": {
					"type": "object"
					"properties": {
						"email": {
							"type":      "string"
							"format":    "email"
							"title":     "E-Mail"
							"minLength": 3
							"ory.sh/kratos": {
								"credentials": {
									"password": {
										"identifier": true
									}
								}
								"verification": {
									"via": "email"
								}
								"recovery": {
									"via": "email"
								}
							}
						}
						"name": {
							"type": "object"
							"properties": {
								"first": {
									"title": "First Name"
									"type":  "string"
								}
								"last": {
									"title": "Last Name"
									"type":  "string"
								}
							}
						}
					}
					"required": ["email", "name"]
					"additionalProperties": false
				}
			}
		})

		"google-mapper.jsonnet":
			"""
					local claims = {
						email_verified: true,
					} + std.extVar('claims');
					
					{
						identity: {
							traits: {
								[if 'email' in claims && claims.email_verified then 'email' else null]: claims.email,
								name: {
									first: claims.given_name,
									last: claims.family_name
								},
							},
						},
					}
				"""
	}
}
