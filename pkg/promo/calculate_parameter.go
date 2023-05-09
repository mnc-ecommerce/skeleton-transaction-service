package promo

type CalculateParameter struct {
	QuoteId       int      `json:"quoteId"`
	Platform      string   `json:"platform"`
	Selected3PlId int      `json:"selected3plId"`
	VoucherCode   []string `json:"voucherCode"`
	ProductList   []struct {
		ProductId          int     `json:"productId"`
		ProductSku         string  `json:"productSku"`
		ProductAmountFinal float64 `json:"productAmountFinal"`
		ProductName        string  `json:"productName"`
	} `json:"productList"`
	SelectedBenefit []struct {
		PromoId            int `json:"promoId"`
		ProductBenefitList []struct {
			ProductId      int     `json:"productId"`
			ProductSku     string  `json:"productSku"`
			ProductName    string  `json:"productName"`
			DiscountAmount float64 `json:"discountAmount"`
		} `json:"productBenefitList"`
	} `json:"selectedBenefit"`
}
