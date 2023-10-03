package kratos

import (
	apps_v1 "k8s.io/api/apps/v1"
)

deployment: apps_v1.#Deployment

deployment: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "expedition-kratos"
	spec: {
		replicas: 1
		selector: matchLabels: app: "expedition-kratos"
		template: {
			metadata: labels: app: "expedition-kratos"
			spec: containers: [{
				name:  "expedition-kratos"
				image: "expedition-kratos:latest"
				args: ["serve", "--dev", "--config", "/etc/config/kratos/kratos.yaml"]
				imagePullPolicy: "Never"
				ports: [{
					containerPort: 4433
				}, {
					containerPort: 4434
				}]
				env: [{
					name: "METHODS_OIDC_CONFIG_PROVIDERS_0_CLIENT_ID"
					valueFrom: secretKeyRef: {
						name: "expedition-kratos-google"
						key:  "client-id"
					}
				}, {
					name: "METHODS_OIDC_CONFIG_PROVIDERS_0_CLIENT_SECRET"
					valueFrom: secretKeyRef: {
						name: "expedition-kratos-google"
						key:  "client-secret"
					}
				}, {
					name: "SERVE_PUBLIC_BASE_URL"
					valueFrom: configMapKeyRef: {
						name: "expedition-kratos-config"
						key:  "serve_public_base_url"
					}
				}, {
					name: "SERVE_ADMIN_BASE_URL"
					valueFrom: configMapKeyRef: {
						name: "expedition-kratos-config"
						key:  "serve_admin_base_url"
					}
				}, {
					name: "COOKIES_DOMAIN"
					valueFrom: configMapKeyRef: {
						name: "expedition-kratos-config"
						key:  "cookies_domain"
					}
				}, {
					name: "UI_BASE_URL"
					valueFrom: configMapKeyRef: {
						name: "expedition-kratos-config"
						key:  "ui_base_url"
					}
				}, {
					name:  "SELFSERVICE_FLOWS_LOGIN_UI_URL"
					value: "$(UI_BASE_URL)/login"
				}, {
					name:  "SELFSERVICE_FLOWS_ERROR_UI_URL"
					value: "$(UI_BASE_URL)/login/error"
				}]
			}]
		}
	}
}
