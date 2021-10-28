package main

import (
        "fmt"
        "log"
        "net/http"
        "os"
		"encoding/json"
)

func main() {

	log.Print("Starting server...")
	
	http.HandleFunc("/", handlerMain)
	http.HandleFunc("/hello", handlerHello)
	http.HandleFunc("/sample_post", handlerSamplePost)

	// Determine port for HTTP service.
	port := os.Getenv("PORT")
	if port == "" {
			port = "8080"
			log.Printf("Defaulting to port %s", port)
	}

	// Start HTTP server.
	log.Printf("Listening on port %s", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
			log.Fatal(err)
	}
}

func handlerMain(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "It works.")
}

func handlerHello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World!")
}

func handlerSamplePost(w http.ResponseWriter, r *http.Request) {

	var chatpaylod map[string]interface{}

    if r.URL.Path != "/sample_post" {
        http.Error(w, "404 not found.", http.StatusNotFound)
        return
    }

    switch r.Method {
    case "GET":
    
		fmt.Fprintf(w, "Endpoint used for Sample POST\n")
		//http.ServeFile(w, r, "form.html")
	
    case "POST":
        if err := r.ParseForm(); err != nil {
            fmt.Fprintf(w, "ParseForm() err: %v\n", err)
            return
        }

		fmt.Printf("FormValue %v\n", r)

		// Used for JSON POST
		err := json.NewDecoder(r.Body).Decode(&chatpaylod)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		/*
		// Used to parse FORM input
        name := r.FormValue("name")
        age := r.FormValue("age")
		*/

		/*
		// Used to parse JSON input
		name := chatpaylod["name"]
		*/

		// Convert map to JSON for printing purposes
		jsonStr, err := json.Marshal(chatpaylod)
		if err != nil {
			fmt.Printf("Error: %s", err.Error())
		} else {
			fmt.Println(string(jsonStr))
		}
        fmt.Fprintf(w, "Payload received: %v", string(jsonStr))

    default:
        fmt.Fprintf(w, "Sorry, only GET and POST methods are supported.")
    }
}
