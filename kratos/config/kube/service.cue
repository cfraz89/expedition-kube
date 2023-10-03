package kratos

import (
	"k8s.io/api/core/v1"
)

service: v1.#Service

service: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "expedition-kratos"
		labels: app: "expedition-kratos"
	}
	spec: {
		ports: [{
			name:       "public"
			port:       4433
			targetPort: 4433
		}, {
			name:       "admin"
			port:       4434
			targetPort: 4434
		}]
		selector: app: "expedition-kratos"
	}
}
