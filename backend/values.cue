// Code generated by timoni.
// Note that this file must have no imports and all values must be concrete.

@if(!debug)

package main

// Defaults
values: {
	image: {
		repository: "expedition-backend"
		tag:        "latest"
		digest:     ""
	}

	googleApiKey: ""

	surreal: {
		uri:      "expedition-surreal:8000"
		user:     "root"
		password: "root"
	}
}