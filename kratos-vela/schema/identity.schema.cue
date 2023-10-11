package schema

#IdentitySchemaConfig: {
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
}