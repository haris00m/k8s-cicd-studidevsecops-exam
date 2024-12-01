package config

import (
	"github.com/spf13/viper"
	"log"
	"os"
	"path/filepath"
)

func ViperConfig() {
	// Find the absolute path of the current working directory
	exePath, err := os.Executable() // Get the path to the executable
	if err != nil {
		log.Fatal(err)
	}
	exeDir := filepath.Dir(exePath) // Get the directory of the executable

	// Specify the path to .env relative to the working directory
	viper.SetConfigFile(filepath.Join(exeDir, ".env"))

	// Automatically read variables from environment if not found in .env
	viper.AutomaticEnv()

	// Attempt to read the .env file
	if err := viper.ReadInConfig(); err != nil {
		log.Println("No .env file found, using environment variables only")
	}
}
