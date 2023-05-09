package handler

import (
	promo "am-promo-svc/internal/promo/handler/v1"
	"am-promo-svc/pkg/repositories"
	"github.com/gofiber/fiber/v2"
)

type Router struct {
}

func (route Router) Routes(router fiber.Router, queries *repositories.Queries) {
	router.Post("/calculate", promo.GetCalculation)
	router.Post("/claim", promo.ClaimPromo)
}
