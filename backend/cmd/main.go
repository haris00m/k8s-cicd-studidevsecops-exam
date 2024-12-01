package main

import (
	"github.com/gin-gonic/gin"
	"github.com/haris00m/goapp/config"
	"github.com/haris00m/goapp/routes"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/spf13/viper"
	"log"
	"net/http"
)

func CORSMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		// Allow all origins
		c.Writer.Header().Set("Access-Control-Allow-Origin", viper.GetString("ALLOW_ORIGIN"))
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(http.StatusOK)
			return
		}

		c.Next()
	}
}

func main() {
	// Initialize database
	config.Connect()

	// Set up Gin router
	r := gin.Default()
	r.Use(CORSMiddleware())

	// Register routes
	routes.RegisterRoutes(r)

	err := r.Run(":8000")
	if err != nil {
		log.Fatal(err)
	}
}
