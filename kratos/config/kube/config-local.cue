package kratos

import (
	"k8s.io/api/core/v1"
)

config: v1.#ConfigMap

config: {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name: "expedition-kratos-config"
	data: {
		serve_public_base_url: "http://kratos.expedition.local"
		serve_admin_base_url:  "http://admin.kratos.expedition.local"
		ui_base_url:           "http://expedition.local:5173"
		cookies_domain:        "expedition.local"
	}
}
