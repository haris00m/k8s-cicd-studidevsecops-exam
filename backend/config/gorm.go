package config

import (
	"fmt"
	"github.com/haris00m/goapp/model"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/spf13/viper"
	"log"
)

var DB *gorm.DB

func Connect() {
	ViperConfig()
	// Retrieve environment variables
	host := viper.GetString("DB_HOST")
	port := viper.GetString("DB_PORT")
	user := viper.GetString("DB_USER")
	password := viper.GetString("DB_PASSWORD")
	dbname := viper.GetString("DB_NAME")

	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable",
		host, user, password, dbname, port)

	database, err := gorm.Open("postgres", dsn)
	if err != nil {
		log.Fatalf("Failed to connect to the database: %v", err)
	}

	database.AutoMigrate(&models.User{})
	DB = database
	fmt.Println("Database connected!")
}
