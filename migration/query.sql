-- name: FindAllActiveMasterPromoToday :many
SELECT promo_id,
       promo_name,
       promo_active,
       promo_start_timestamp,
       promo_end_timestamp,
       created_at,
       created_by,
       updated_at,
       updated_by,
       min_amount,
       min_qty,
       multiplier,
       discount_amount,
       max_discount_amount,
       condition_calculate_method,
       apply_all_product,
       voucher_gen_type,
       promo_type,
       max_quota,
       is_quota_unlimited
FROM master_promo
WHERE promo_active = true
  and current_date between promo_start_timestamp::date and promo_end_timestamp::date;

-- name: GetMasterPromoById :one
SELECT promo_id,
       promo_name,
       promo_active,
       promo_start_timestamp,
       promo_end_timestamp,
       created_at,
       created_by,
       updated_at,
       updated_by,
       min_amount,
       min_qty,
       multiplier,
       discount_amount,
       max_discount_amount,
       condition_calculate_method,
       apply_all_product,
       voucher_gen_type,
       promo_type,
       max_quota,
       is_quota_unlimited
FROM master_promo
WHERE promo_id = @promoId;

-- name: GetMasterPromoCondition3PlBy :one
SELECT promo_id,
       id_3pl,
       condition_enabled,
       condition_start_timestamp,
       condition_end_timestamp,
       created_at,
       created_by,
       updated_at,
       updated_by
FROM master_promo_condition_3pl
WHERE promo_id = @promoId
  AND id_3pl = @id3pl;

-- name: GetMasterPromoConditionPlatformBy :one
SELECT promo_id,
       platform_type,
       condition_enabled,
       condition_start_timestamp,
       condition_end_timestamp,
       created_at,
       created_by,
       updated_at,
       updated_by
FROM master_promo_condition_platform
WHERE promo_id = @promoId
  AND platform_type = @platformType;

-- name: GetMasterPromoConditionProductBy :one
SELECT promo_id,
       product_id,
       created_at,
       created_by,
       updated_at,
       updated_by,
       condition_enable,
       condition_start_timestamp,
       condition_end_timestamp
FROM master_promo_condition_product
WHERE promo_id = @promoId
  AND product_id = @productId;

-- name: GetMasterPromoProductBenefitBy :one
SELECT promo_id,
       product_id,
       product_final_price,
       benefit_enable,
       benefit_start_timestamp,
       benefit_end_timestamp,
       created_at,
       created_by,
       updated_at,
       updated_by,
       available_stock
FROM master_promo_product_benefit
WHERE promo_id = @promoId
  AND product_id = @productId;

-- name: GetMasterPromoVoucherBy :one
SELECT promo_id,
       voucher_code,
       voucher_enabled,
       voucher_start_timestamp,
       voucher_end_timestamp,
       created_at,
       created_by,
       updated_at,
       updated_by
FROM master_promo_voucher
WHERE promo_id = @promoId
  AND voucher_code = @voucherCode;

-- name: CreateMasterPromo :one
INSERT INTO master_promo (promo_id, promo_name, promo_active, promo_start_timestamp, promo_end_timestamp, created_at,
                          created_by, updated_at, updated_by, min_amount, min_qty, multiplier, discount_amount,
                          max_discount_amount, condition_calculate_method, apply_all_product, voucher_gen_type,
                          promo_type, max_quota, is_quota_unlimited)
VALUES (@promoId, @promoName, @promoActive, @promoStartTimestamp, @promoEndTimestamp, @createdAt, @createdBy,
        @updatedAt, @updatedBy, @minAmount, @minQty, @multiplier, @discountAmount, @maxDiscountAmount,
        @conditionCalculateMethod, @applyAllProduct, @voucherGenType, @promoType, @maxQuota, @isQuotaUnlimited)
RETURNING *;

-- name: CreateMasterPromoCondition3pl :one
INSERT INTO master_promo_condition_3pl (promo_id, id_3pl, condition_enabled, condition_start_timestamp,
                                        condition_end_timestamp, created_at, created_by, updated_at, updated_by)
VALUES (@promoId, @id3pl, @conditionEnabled, @conditionStartTimestamp, @conditionEndTimestamp, @createdAt, @createdBy,
        @updatedAt, @updatedBy)
RETURNING *;

-- name: CreateMasterPromoConditionPlatform :one
INSERT INTO master_promo_condition_platform (promo_id, platform_type, condition_enabled, condition_start_timestamp,
                                             condition_end_timestamp, created_at, created_by, updated_at, updated_by)
VALUES (@promoId, @platformType, @conditionEnabled, @conditionStartTimestamp, @conditionEndTimestamp, @createdAt,
        @createdBy, @updatedAt, @updatedBy)
RETURNING *;

-- name: CreateMasterPromoConditionProduct :one
INSERT INTO master_promo_condition_product (promo_id, product_id, created_at, created_by, updated_at, updated_by,
                                            condition_enable, condition_start_timestamp, condition_end_timestamp)
VALUES (@promoId, @productId, @createdAt, @createdBy, @updatedAt, @updatedBy, @conditionEnable,
        @conditionStartTimestamp, @conditionEndTimestamp)
RETURNING *;

-- name: CreateMasterPromoProductBenefit :one
INSERT INTO master_promo_product_benefit (promo_id, product_id, product_final_price, benefit_enable,
                                          benefit_start_timestamp, benefit_end_timestamp, created_at, created_by,
                                          updated_at, updated_by, available_stock)
VALUES (@promoId, @productId, @productFinalPrice, @benefitEnable, @benefitStartTimestamp, @benefitEndTimestamp,
        @createdAt, @createdBy, @updatedAt, @updatedBy, @availableStock)
RETURNING *;

-- name: CreateMasterPromoVoucher :one
INSERT INTO master_promo_voucher (promo_id, voucher_code, voucher_enabled, voucher_start_timestamp,
                                  voucher_end_timestamp, created_at, created_by, updated_at, updated_by)
VALUES (@promoId, @voucherCode, @voucherEnabled, @voucherStartTimestamp, @voucherEndTimestamp, @createdAt, @createdBy,
        @updatedAt, @updatedBy)
RETURNING *;
