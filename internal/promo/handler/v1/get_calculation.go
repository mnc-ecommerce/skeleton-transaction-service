package v1

import "github.com/gofiber/fiber/v2"

func GetCalculation(ctx *fiber.Ctx) error {
	return ctx.JSON("Haloooo")
}
