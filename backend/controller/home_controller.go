package controllers

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func Home(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": "Welcome to GoApp API",
		"endpoints": gin.H{
			"get_users":   "/users",
			"get_user":    "/users/:id",
			"create_user": "/users",
			"update_user": "/users/:id",
			"delete_user": "/users/:id",
		},
	})
}
