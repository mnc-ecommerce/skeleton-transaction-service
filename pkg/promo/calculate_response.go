package promo

import "encoding/json"

type AvailableBenefit struct {
	PromoId            int                `json:"promoId"`
	IsFree             bool               `json:"isFree"`
	IsAvailable        bool               `json:"isAvailable"`
	PromoName          string             `json:"promoName"`
	NotAvailableReason NotAvailableReason `json:"notAvailableReason,omitempty"`
	VoucherCode        string             `json:"voucherCode,omitempty"`
	ProductBenefitList []struct {
		ProductId      int     `json:"productId"`
		ProductSku     string  `json:"productSku"`
		DiscountAmount float64 `json:"discountAmount"`
		ProductName    string  `json:"productName"`
	} `json:"productBenefitList,omitempty"`
}

type CalculateResponse struct {
	QuoteId          int                `json:"quoteId"`
	Platform         string             `json:"platform"`
	AvailableBenefit []AvailableBenefit `json:"availableBenefit"`
}

type NotAvailableReason struct {
	IsValid bool   `json:"-"` //this field, is internal use only. won't be marshalled into json
	Code    string `json:"code"`
	Label   string `json:"label"`
}

func (reason NotAvailableReason) MarshalJSON() ([]byte, error) {
	if !reason.IsValid {
		return []byte("null"), nil
	}
	return json.Marshal(reason)
}
