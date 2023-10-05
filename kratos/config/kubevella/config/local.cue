import "expedition.com.au/kratos-config/base"

config: base.#ConfigMap & {
	#kratos: {
		cookies: domain: "expedition.local"
		#ui_base_url: "http://expedition.local:5173"

		serve: {
			public: {
				base_url: "http://kratos.expedition.local"
			}
			admin: {
				base_url: "http://admin.kratos.expedition.local"
			}
		}
	}
}
