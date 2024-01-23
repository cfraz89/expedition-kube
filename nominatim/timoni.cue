// Code generated by timoni.
// Note that this file is required and should contain
// the values schema and the timoni workflow.

package main

import (
	"strconv"
	"strings"

	templates "timoni.sh/nominatim/templates"
)

// Define the schema for the user-supplied values.
// At runtime, Timoni injects the supplied values
// and validates them according to the Config schema.
values: templates.#Config

// Define how Timoni should build, validate and
// apply the Kubernetes resources.
timoni: {
	apiVersion: "v1alpha1"

	// Define the instance that outputs the Kubernetes resources.
	// At runtime, Timoni builds the instance and validates
	// the resulting resources according to their Kubernetes schema.
	instance: templates.#Instance & {
		// The user-supplied values are merged with the
		// default values at runtime by Timoni.
		config: values
		// These values are injected at runtime by Timoni.
		config: {
			metadata: {
				name:      string @tag(name)
				namespace: string @tag(namespace)
			}
			moduleVersion: string @tag(mv, var=moduleVersion)
			kubeVersion:   string @tag(kv, var=kubeVersion)
		}
	}

	// Enforce minimum Kubernetes version.
	kubeMinorVersion: int & >=20
	kubeMinorVersion: strconv.Atoi(strings.Split(instance.config.kubeVersion, ".")[1])

	// Pass Kubernetes resources outputted by the instance
	// to Timoni's multi-step apply.
	apply: all: [ for obj in instance.objects {obj}]
}