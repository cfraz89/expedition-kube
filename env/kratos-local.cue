values: {
	uiBaseUrl: "http://expedition.local:5173"
	kratos: {
		cookies: domain: "expedition.local"

		serve: {
			public: {
				base_url: "http://kratos.expedition.local"
			}
			admin: {
				base_url: "http://admin.kratos.expedition.local"
			}
		}

		selfservice: {
			methods: {
				password: enabled: false
				oidc: {
					enabled: true
				}
			}
		}

		secrets: cookie: [
			"LOCALCOOKIESECRET",
		]
	}
}
