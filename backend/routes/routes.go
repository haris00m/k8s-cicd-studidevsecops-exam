package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/haris00m/goapp/controller"
)

func RegisterRoutes(r *gin.Engine) {
	r.GET("/", controllers.Home)
	r.GET("/users", controllers.GetUsers)
	r.GET("/users/:id", controllers.GetUser)
	r.POST("/users", controllers.CreateUser)
	r.PUT("/users/:id", controllers.UpdateUser)
	r.DELETE("/users/:id", controllers.DeleteUser)
}
