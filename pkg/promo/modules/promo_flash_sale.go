package modules

import "am-promo-svc/pkg/promo"

type PromoFlashSale struct {
}

func (module PromoFlashSale) Calculate(parameter promo.CalculateParameter) promo.AvailableBenefit {
	return promo.AvailableBenefit{}
}
