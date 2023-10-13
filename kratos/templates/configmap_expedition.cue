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
		configFiles: "google-mapper.jsonnet": """
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
