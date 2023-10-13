package templates

import (
	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
)

#Deployment: appsv1.#Deployment & {
	_config:    #Config
	_cmName:    string
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata:   _config.metadata
	spec:       appsv1.#DeploymentSpec & {
		replicas: _config.replicas
		selector: matchLabels: _config.selector.labels
		template: {
			metadata: {
				labels: _config.selector.labels
				if _config.podAnnotations != _|_ {
					annotations: _config.podAnnotations
				}
			}
			spec: corev1.#PodSpec & {
				containers: [
					{
						if _config.dev {
							args: ["serve", "--dev", "--config", "/etc/config/kratos.yaml"]
						}
						if !_config.dev {
							args: ["serve", "--config", "/etc/config/kratos.yaml"]
						}

						name:            _config.metadata.name
						image:           _config.image.reference
						imagePullPolicy: _config.imagePullPolicy
						ports: [
							{
								name:          "public"
								containerPort: 4433
							},
							{
								name:          "admin"
								containerPort: 4434
							},
						]
						volumeMounts: [
							{
								mountPath: "/etc/config"
								name:      "config"
								readOnly:  true
							},
						]
						if _config.resources != _|_ {
							resources: _config.resources
						}
						if _config.securityContext != _|_ {
							securityContext: _config.securityContext
						}
					},
				]
				volumes: [
					{
						name: "config"
						configMap: name: _cmName
					},
				]
				if _config.podSecurityContext != _|_ {
					securityContext: _config.podSecurityContext
				}
				if _config.topologySpreadConstraints != _|_ {
					topologySpreadConstraints: _config.topologySpreadConstraints
				}
				if _config.affinity != _|_ {
					affinity: _config.affinity
				}
				if _config.tolerations != _|_ {
					tolerations: _config.tolerations
				}
				if _config.imagePullSecrets != _|_ {
					imagePullSecrets: _config.imagePullSecrets
				}
			}
		}
	}
}
