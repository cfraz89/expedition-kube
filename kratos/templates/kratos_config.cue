package templates

#KratosConfig: {
	version: string

	dsn: string

	cookies: domain: string

	serve: {
		public: {
			base_url: string
			cors: enabled: bool
		}
		admin: base_url: string
	}

	selfservice: {
		default_browser_return_url: string
		allowed_return_urls: [
			...string,
		]

		methods: {
			password: enabled: bool
			oidc: {
				enabled: bool
				config_providers: [
					...{
						[string]: {
							id:            string
							provider:      string
							client_id:     string
							client_secret: string
							mapper_url:    string
						}
					},
				]
			}
		}

		flows: {
			error: ui_url: string

			settings: {
				ui_url:                     string
				privileged_session_max_age: string
			}

			recovery: {
				enabled: bool
				ui_url:  string
			}

			verification: {
				enabled: bool
				ui_url:  string
				after: default_browser_return_url: string
			}

			logout: after: default_browser_return_url: string

			login: ui_url: string

			registration: {
				ui_url: string
				after: password: hooks: [...{
					hook: string
				}]
			}
		}
	}

	log: {
		level:  string
		format: string
	}

	secrets: cookie: [
		string,
	]

	hashers: {
		algorithm: string
		bcrypt: cost: number
	}

	identity: {
		default_schema_id: string
		schemas: [{
			id:  string
			url: string
		}]
	}

	courier: smtp: connection_uri: string
}
