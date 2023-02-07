package main

import (
	"fmt"
	"net/http"
)

func index(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "This is golang web\n")
}

func main() {

	http.HandleFunc("/", index)

	http.ListenAndServe(":9090", nil)
}
