import config "expedition.com.au/kratos-config/base:config"

config: config.#Config & {
	#kratos: {
		serve: {
			public: {
				base_url: serve_public_base_url
			}
		}
	}
}
serve_public_base_url: "http://kratos.expedition.local"
serve_admin_base_url:  "http://admin.kratos.expedition.local"
ui_base_url:           "http://expedition.local:5173"
cookies_domain:        "expedition.local"
