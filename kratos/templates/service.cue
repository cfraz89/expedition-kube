package templates

import (
	corev1 "k8s.io/api/core/v1"
)

#Service: corev1.#Service & {
	_config:    #Config
	apiVersion: "v1"
	kind:       "Service"
	metadata:   _config.metadata
	spec:       corev1.#ServiceSpec & {
		type:     corev1.#ServiceTypeClusterIP
		selector: _config.selector.labels
		ports: [{
			name:       "public"
			port:       4433
			targetPort: 4433
		}, {
			name:       "admin"
			port:       4434
			targetPort: 4434
		}]
	}
}
