package main

import (
	"github.com/kelseyhightower/envconfig"
	log "github.com/sirupsen/logrus"
	"example-module/cmd/example-app/utils"
	"example-module/http"
)

func main() {

	var cfg utils.Config
	err := envconfig.Process("", &cfg)
	if err != nil {
		log.Fatal(err)
	}

	var environment = cfg.Environment
	var logLevel = cfg.LogLevel
	initLogger(logLevel)

	httpserver := http.NewServer(environment)

	if err := httpserver.Open(); err != nil {
		log.Fatalf("error: %s", err)
	}

	defer httpserver.Close()

}

func initLogger(level string) {
	parsedLevel, err := log.ParseLevel(level)
	if err != nil {
		log.Error(err)
		parsedLevel = log.InfoLevel
	}
	log.SetFormatter(&log.JSONFormatter{})
	log.SetLevel(parsedLevel)
}
