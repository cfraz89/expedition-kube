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
	imagePullPolicy:  *"IfNotPresent" | string
	resources?:       corev1.#ResourceRequirements
	securityContext?: corev1.#SecurityContext

	// Service
	service: {
		publicPort: *4433 | int & >0 & <=65535
		adminPort:  *4434 | int & >0 & <=65535
	}

	//Kratos 
	dev:                bool
	hostname:           string
	uiBaseUrl:          string
	googleClientId:     string
	googleClientSecret: string

	kratos: #KratosConfig & {
		_ui_base_url:          uiBaseUrl
		_google_client_id:     googleClientId
		_google_client_secret: googleClientSecret
	}

	identitySchema: {[string]: _}
	configFiles: {[string]: string}
}

// Instance takes the config values and outputs the Kubernetes objects.
#Instance: {
	config: #Config

	objects: {
		svc:     #Service & {_config:   config}
		cm:      #ConfigMap & {_config: config}
		ingress: #Ingress & {_config:   config}

		deploy: #Deployment & {
			_config:        config
			_configMapName: cm.metadata.name
		}
	}
}
