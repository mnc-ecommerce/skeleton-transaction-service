package v1

import "github.com/gofiber/fiber/v2"

func ClaimPromo(ctx *fiber.Ctx) error {
	return ctx.JSON("Hallooo")
}
