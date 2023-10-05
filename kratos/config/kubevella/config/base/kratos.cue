package base

#KratosConfig: {
	version: "v0.13.0"

	dsn: string | *"memory"

	cookies: domain: string | *"localhost"

	#ui_base_url: string

	serve: {
		public: {
			base_url: string | *"http://localhost:4455/"
			cors: enabled: true
		}
		admin: base_url: string | *"http://kratos:4434/"
	}

	selfservice: {
		default_browser_return_url: "\(#ui_base_url)/ui/welcome"
		allowed_return_urls: [
			serve.public.base_url,
		]

		methods: {
			password: enabled: bool | *false
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
			error: ui_url: "\(#ui_base_url)/login/error"

			settings: {
				ui_url:                     "\(#ui_base_url)/ui/settings"
				privileged_session_max_age: "15m"
			}

			recovery: {
				enabled: true
				ui_url:  "\(#ui_base_url)/ui/recovery"
			}

			verification: {
				enabled: true
				ui_url:  "\(#ui_base_url)/ui/verification"
				after: default_browser_return_url: "\(#ui_base_url)/ui/welcome"
			}

			logout: after: default_browser_return_url: "\(#ui_base_url)/ui/login"

			login: ui_url: "\(#ui_base_url)/login"

			registration: {
				ui_url: "\(#ui_base_url)/ui/registration"
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
}
