package promo

type CalculatorStrategy interface {
	Calculate(parameter CalculateParameter) AvailableBenefit
}
