package kratos

version: "v0.13.0"

dsn: "memory"

cookies: domain: "localhost"

serve: {
	public: {
		base_url: "http://localhost:4455/"
		cors: enabled: true
	}
	admin: base_url: "http://kratos:4434/"
}

selfservice: {
	default_browser_return_url: "http://localhost:4455/ui/welcome"
	allowed_return_urls: [
		"http://localhost:4455",
	]

	methods: {
		password: enabled: false
		oidc: {
			enabled: true
			config: providers: [{
				id:            "google"
				provider:      "google"
				client_id:     "from-env-var"
				client_secret: "from-env-var"
				mapper_url:    "file:///etc/config/google-mapper.jsonnet"
			}]
		}
	}

	flows: {
		error: ui_url: "http://localhost:4455/ui/error"

		settings: {
			ui_url:                     "http://localhost:4455/ui/settings"
			privileged_session_max_age: "15m"
		}

		recovery: {
			enabled: true
			ui_url:  "http://localhost:4455/ui/recovery"
		}

		verification: {
			enabled: true
			ui_url:  "http://localhost:4455/ui/verification"
			after: default_browser_return_url: "http://localhost:4455/ui/welcome"
		}

		logout: after: default_browser_return_url: "http://localhost:4455/ui/login"

		login: ui_url: "http://localhost:4455/ui/login"

		registration: {
			ui_url: "http://localhost:4455/ui/registration"
			after: password: hooks: [{
				hook: "session"
			}]
		}
	}
}

log: {
	level:  "info"
	format: "text"
}

secrets: cookie: [
	"PLEASE-CHANGE-ME-I-AM-VERY-INSECURE",
]

hashers: {
	algorithm: "bcrypt"
	bcrypt: cost: 8
}

identity: {
	default_schema_id: "preset://email"
	schemas: [{
		id:  "preset://email"
		url: "file:///etc/config/identity.schema.json"
	}]
}

courier: smtp: connection_uri: "smtps://test:test@mailslurper:1025/?skip_ssl_verify=true"
