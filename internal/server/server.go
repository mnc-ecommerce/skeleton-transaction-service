package server

import (
	"am-promo-svc/internal/promo/handler"
	"am-promo-svc/pkg/repositories"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/compress"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"time"
)

const idleTimeout = 5 * time.Second

func SetupServer() *fiber.App {
	app := fiber.New(
		fiber.Config{
			IdleTimeout: idleTimeout,
			Prefork:     true,
		})
	app.Use(logger.New())
	app.Use(compress.New(compress.Config{
		Level: compress.LevelBestCompression,
	}))
	return app
}

func CreateRoute(app *fiber.App, repository *repositories.Queries) {
	router := handler.Router{}
	promoGroupV1 := app.Group("/promo/v1")
	router.Routes(promoGroupV1, repository)
}
