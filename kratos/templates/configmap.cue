package templates

import (
	"encoding/yaml"
	"encoding/json"
	corev1 "k8s.io/api/core/v1"
)

#ConfigMap: corev1.#ConfigMap & {
	_config:    #Config
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: {
		name:      _config.metadata.name
		namespace: _config.metadata.namespace
		labels:    _config.metadata.labels
		if _config.metadata.annotations != _|_ {
			annotations: _config.metadata.annotations
		}
	}
	data: {
		"kratos.yaml":          yaml.Marshal(_config.kratos)
		"identity.schema.json": json.Marshal(_config.identitySchema)
	} & _config.configFiles
}
