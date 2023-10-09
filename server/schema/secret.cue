package schema

#Secret: {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: name: "expedition-server-secrets"
	stringData: {
		"google-api-key":   string
		"surreal-user":     string
		"surreal-password": string
	}
}
