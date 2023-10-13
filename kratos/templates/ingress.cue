package templates

import (
	networkingv1 "k8s.io/api/networking/v1"
)

#Ingress: networkingv1.#Ingress & {
	_config:    #Config
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata:   _config.metadata
	spec: rules: [{
		host: _config.hostname
		http: paths: [
			{
				backend: service: {
					name: _config.metadata.name
					port: name: "public"
				}
				path:     "/"
				pathType: "Prefix"
			},
			{
				backend: service: {
					name: _config.metadata.name
					port: name: "admin"
				}
				path:     "/admin"
				pathType: "Prefix"
			},
		]
	}]
}
