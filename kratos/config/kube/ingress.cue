package kratos

import (
	networking_v1 "k8s.io/api/networking/v1"
)

ingress: networking_v1.#Ingress

ingress: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: name: "expedition-kratos"
	spec: rules: [{
		host: "kratos.expedition.local"
		http: paths: [{
			path:     "/"
			pathType: "Prefix"
			backend: service: {
				name: "expedition-kratos"
				port: name: "public"
			}
		}]
	}, {
		host: "admin.kratos.expedition.local"
		http: paths: [{
			path:     "/"
			pathType: "Prefix"
			backend: service: {
				name: "expedition-kratos"
				port: name: "admin"
			}
		}]
	}]
}
