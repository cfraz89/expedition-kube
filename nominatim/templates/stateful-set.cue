package templates

import (
	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
)

#StatefulSet: appsv1.#StatefulSet & {
	_config: #Config
	let postgresPvcName = "\(_config.metadata.name)-postgres-pvc"
	_cmName:    string
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
	metadata:   _config.metadata
	spec:       appsv1.#StatefulSetSpec & {
		replicas: _config.replicas
		selector: matchLabels: _config.selector.labels
		serviceName: _config.metadata.name
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
						name:            _config.metadata.name
						image:           _config.image.reference
						imagePullPolicy: _config.imagePullPolicy
						ports: [
							{
								name:          "nominatim"
								containerPort: 8080
								protocol:      "TCP"
							},
						]
						env: [
							{
								name:  "PBF_URL"
								value: _config.pbfUrl
							},
							{
								name:  "REPLICATION_URL"
								value: _config.replicationUrl
							},
							{
								name:  "IMPORT_STYLE"
								value: "extratags"
							},
						]
						volumeMounts: [
							{
								mountPath: "/var/lib/postgresql/14/main"
								name:      postgresPvcName
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
		volumeClaimTemplates: [{
			metadata: name: postgresPvcName
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: 10Gi
			}
		}]
	}
}
