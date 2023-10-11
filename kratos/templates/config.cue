package templates

import (
	corev1 "k8s.io/api/core/v1"
	timoniv1 "timoni.sh/core/v1alpha1"
)

// Config defines the schema and defaults for the Instance values.
#Config: {
	// Runtime version info
	moduleVersion!: string
	kubeVersion!:   string

	// Metadata (common to all resources)
	metadata: timoniv1.#Metadata & {#Version: moduleVersion}

	// Label selector (common to all resources)
	selector: timoniv1.#Selector & {#Name: metadata.name}

	// Deployment
	replicas: *1 | int & >0

	// Pod
	podAnnotations?: {[ string]: string}
	podSecurityContext?: corev1.#PodSecurityContext
	imagePullSecrets?: [...corev1.LocalObjectReference]
	tolerations?: [ ...corev1.#Toleration]
	affinity?: corev1.#Affinity
	topologySpreadConstraints?: [...corev1.#TopologySpreadConstraint]

	// Container
	image:            timoniv1.#Image
	args?:            *["serve", "--dev", "--config", "/etc/config/kratos.yaml"] | [string]
	imagePullPolicy:  *"IfNotPresent" | string
	resources?:       corev1.#ResourceRequirements
	securityContext?: corev1.#SecurityContext

	kratos: {
		config: {
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

			_oidc_providers: google: {
				client_id:     "hi"
				client_secret: "secret"
			}
		}
	}
}

// Instance takes the config values and outputs the Kubernetes objects.
#Instance: {
	config: #Config

	objects: {
		svc: #Service & {_config:   config}
		cm:  #ConfigMap & {_config: config}

		deploy: #Deployment & {
			_config: config
			_cmName: objects.cm.metadata.name
		}
	}
}
