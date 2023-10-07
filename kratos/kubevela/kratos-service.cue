import "encoding/yaml"

"kratos-service": {
	alias: ""
	annotations: {}
	attributes: {
		workload: definition: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
		}
		status: {
			healthPolicy: #"""
				isHealth: (context.output.status.readyReplicas > 0) && (context.output.status.readyReplicas == context.output.status.replicas)
				"""#
		}
	}
	description: "Kratos service"
	labels: {}
	type: "component"
}

template: {
	output: {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: name: context.name
		spec: {
			replicas: parameter.replicas
			selector: matchLabels: app: context.name
			template: {
				metadata: labels: app: context.name
				spec: {
					containers: [{
						args: ["serve", "--dev", "--config", "/etc/config/kratos.yaml"]
						env: [{
							name: "METHODS_OIDC_CONFIG_PROVIDERS"
							valueFrom: secretKeyRef: {
								key:  "oidc-config-providers"
								name: "expedition-kratos-secrets"
							}
						}]
						image: "oryd/kratos:v1.0.0"
						name:  context.name
						ports: [{
							containerPort: 4433
						}, {
							containerPort: 4434
						}]
						volumeMounts: [{
							name:      "config-volume"
							mountPath: "/etc/config"
						}]
					}]
					volumes: [{
						name: "config-volume"
						configMap: name: "expedition-kratos-config"
					}]
				}
			}
		}
	}
	outputs: {
		ingress: {
			apiVersion: "networking.k8s.io/v1"
			kind:       "Ingress"
			metadata: name: context.name
			spec: rules: [{
				host: parameter.hostname
				http: paths: [
					{
						backend: service: {
							name: context.name
							port: name: "public"
						}
						path:     "/"
						pathType: "Prefix"
					},
					{
						backend: service: {
							name: context.name
							port: name: "admin"
						}
						path:     "/admin"
						pathType: "Prefix"
					},
				]
			}]
		}
		service: {
			apiVersion: "v1"
			kind:       "Service"
			metadata: {
				name: context.name
				labels: app: context.name
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
				selector: app: context.name
			}
		}
	}
	parameter: {
		replicas: *1 | int
		hostname: string
	}
}
