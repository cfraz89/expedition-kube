package templates

#ExpeditionKratosConfig: #KratosConfig
#ExpeditionKratosConfig: {
	version: "v1.0"

	_ui_base_url:          string
	_google_client_id:     string
	_google_client_secret: string

	serve: {
		public: {
			base_url: string
		}
	}

	selfservice: {
		default_browser_return_url: "\(_ui_base_url)/ui/welcome"
		allowed_return_urls: [
			serve.public.base_url,
		]

		methods: {
			password: enabled: false
			oidc: {
				enabled: true
				config: providers: [{
					id:            "google"
					provider:      "google"
					client_id:     _google_client_id
					client_secret: _google_client_secret
					mapper_url:    "file:///etc/config/google-mapper.jsonnet"
				}]
			}
		}

		flows: {
			error: ui_url: "\(_ui_base_url)/login/error"

			settings: {
				ui_url:                     "\(_ui_base_url)/ui/settings"
				privileged_session_max_age: "15m"
			}

			recovery: {
				enabled: true
				ui_url:  "\(_ui_base_url)/ui/recovery"
			}

			verification: {
				enabled: true
				ui_url:  "\(_ui_base_url)/ui/verification"
				after: default_browser_return_url: "\(_ui_base_url)/ui/welcome"
			}

			logout: after: default_browser_return_url: "\(_ui_base_url)/ui/login"

			login: ui_url: "\(_ui_base_url)/login"

			registration: {
				ui_url: "\(_ui_base_url)/ui/registration"
				after: password: hooks: [{
					hook: "session"
				}]
			}
		}
	}

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
}
