package schema

#OidcProviders: {
	google: {
		id:            "google"
		provider:      "google"
		client_id:     string
		client_secret: string
		mapper_url:    "file:///etc/config/google-mapper.jsonnet"
	}
}

#Secret: {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: name: "expedition-kratos-secrets"
	stringData: {
		"oidc-config-providers": string
	}
}
