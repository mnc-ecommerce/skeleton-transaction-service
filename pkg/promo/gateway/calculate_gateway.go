package gateway

import (
	"am-promo-svc/pkg/promo"
	"am-promo-svc/pkg/promo/modules"
	"am-promo-svc/pkg/repositories"
	"context"
	"errors"
	"log"
)

type Calculate struct {
	context.Context
	query *repositories.Queries
}

func (gateway Calculate) CalculatePromo(parameter promo.CalculateParameter) promo.CalculateResponse {
	today, err := gateway.query.FindAllActiveMasterPromoToday(gateway.Context)
	if err != nil {
		return promo.CalculateResponse{}
	}

	var availableBenefitList []promo.AvailableBenefit
	for _, masterPromo := range today {
		promoStrategy, err := newStrategyFrom(masterPromo.PromoType)
		if err != nil {
			log.Println(err)
			continue
		}
		_ = append(availableBenefitList, promoStrategy.Calculate(parameter))
	}

	return promo.CalculateResponse{
		QuoteId:          parameter.QuoteId,
		Platform:         parameter.Platform,
		AvailableBenefit: availableBenefitList,
	}
}

func newStrategyFrom(promoType string) (promo.CalculatorStrategy, error) {
	switch promoType {
	case "FLASH_SALE":
		return modules.PromoFlashSale{}, nil
	default:
		return nil, errors.New("unknown Module ")
	}
}
