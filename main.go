package main

import (
"fmt"
"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hello world!")
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Simple Helloworld server is running on port 8080")
	http.ListenAndServe(":8080", nil)
}