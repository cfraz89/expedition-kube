values: {
	dev:      true
	hostname: "identity.expedition.local.com"

	uiBaseUrl: "http://expedition.local.com:5173"

	kratos: {
		cookies: domain: "expedition.local.com"

		serve: {
			public: {
				base_url: "http://identity.expedition.local.com"
			}
			admin: {
				base_url: "http://identity.expedition.local.com/admin"
			}
		}

		secrets: cookie: [
			"LOCALCOOKIESECRET",
		]
	}
}
