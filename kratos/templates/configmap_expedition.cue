package templates

#ConfigMap: {
	_config: {
		identitySchema: {
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
						"first_name": {
							"type":  "string"
							"title": "First Name"
						}
						"last_name": {
							"type":  "string"
							"title": "Last Name"
						}
					}
					"required": ["email"]
					"additionalProperties": false
				}
			}
		}
		configFiles: "google-mapper.jsonnet": """
			local claims = {
				email_verified: true,
			} + std.extVar('claims');

			{
				identity: {
					traits: {
						[if 'email' in claims && claims.email_verified then 'email' else null]: claims.email,
						[if 'given_name' in claims then 'first_name' else null]:  claims.given_name,
						[if 'family_name' in claims then 'last_name' else null]: claims.family_name
					},
				},
			}
			"""
	}
}
