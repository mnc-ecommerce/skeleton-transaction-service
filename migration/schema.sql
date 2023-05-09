create type voucher_gen_type as enum ('NO_CODE', 'SINGLE_CODE', 'MULTIPLE_CODE');

create type condition_calculate_method as enum ('WHOLE_CART', 'SYARAT_ONLY');

create type condition_platform as enum ('ANDROID', 'IOS', 'MOBILE_WEB', 'DESKTOP');

create table master_promo
(
    promo_id                   bigserial
        constraint master_promo_pk
            primary key,
    promo_name                 varchar                                                      not null,
    promo_active               boolean                  default false                       not null,
    promo_start_timestamp      timestamp with time zone default now()                       not null,
    promo_end_timestamp        timestamp with time zone default (now() + '1 day'::interval) not null,
    created_at                 timestamp with time zone default now()                       not null,
    created_by                 varchar                                                      not null,
    updated_at                 timestamp with time zone,
    updated_by                 varchar,
    min_amount                 double precision,
    min_qty                    integer,
    multiplier                 integer                  default 1                           not null,
    discount_amount            double precision,
    max_discount_amount        integer,
    condition_calculate_method condition_calculate_method                                   not null,
    apply_all_product          boolean                  default false                       not null,
    voucher_gen_type           voucher_gen_type         default 'NO_CODE'::voucher_gen_type not null,
    promo_type                 varchar                                                      not null,
    max_quota                  integer,
    is_quota_unlimited         boolean                  default false                       not null
);

create index master_promo_promo_active_promo_start_timestamp_promo_end_times
    on master_promo (promo_active, promo_start_timestamp, promo_end_timestamp);

create table master_promo_condition_product
(
    promo_id                  bigint                                 not null
        constraint master_promo_condition_product_master_promo_promo_id_fk
            references master_promo,
    product_id                bigint                                 not null,
    created_at                timestamp with time zone default now() not null,
    created_by                varchar                                not null,
    updated_at                timestamp with time zone,
    updated_by                varchar,
    condition_enable          boolean                  default false not null,
    condition_start_timestamp timestamp with time zone default now() not null,
    condition_end_timestamp   timestamp with time zone,
    constraint master_promo_condition_product_pk
        primary key (promo_id, product_id)
);

create index master_promo_condition_product_condition_enable_condition_start
    on master_promo_condition_product (condition_enable, condition_start_timestamp, condition_end_timestamp);

create table master_promo_product_benefit
(
    promo_id                bigint                                                       not null
        constraint master_promo_product_benefit_master_promo_promo_id_fk
            references master_promo,
    product_id              bigint                                                       not null,
    product_final_price     double precision,
    benefit_enable          boolean                  default false                       not null,
    benefit_start_timestamp timestamp with time zone default now()                       not null,
    benefit_end_timestamp   timestamp with time zone default (now() + '1 day'::interval) not null,
    created_at              timestamp with time zone default now()                       not null,
    created_by              varchar                                                      not null,
    updated_at              timestamp with time zone,
    updated_by              varchar,
    available_stock         integer,
    constraint master_promo_product_benefit_pk
        primary key (promo_id, product_id)
);

create index master_promo_product_benefit_benefit_enable_benefit_start_times
    on master_promo_product_benefit (benefit_enable, benefit_start_timestamp, benefit_end_timestamp);

create table master_promo_condition_platform
(
    promo_id                  bigint                                                       not null
        constraint master_promo_condition_platform_master_promo_promo_id_fk
            references master_promo,
    platform_type             condition_platform                                           not null,
    condition_enabled         boolean                  default false                       not null,
    condition_start_timestamp timestamp with time zone default now()                       not null,
    condition_end_timestamp   timestamp with time zone default (now() + '1 day'::interval) not null,
    created_at                timestamp with time zone default now()                       not null,
    created_by                varchar                                                      not null,
    updated_at                timestamp with time zone                                     not null,
    updated_by                varchar,
    constraint master_promo_condition_platform_pk
        primary key (promo_id, platform_type)
);

create index master_promo_condition_platform_condition_enabled_condition_sta
    on master_promo_condition_platform (condition_enabled, condition_start_timestamp, condition_end_timestamp);

create table master_promo_condition_3pl
(
    promo_id                  bigint                                                       not null
        constraint master_promo_condition_3pl_master_promo_promo_id_fk
            references master_promo,
    id_3pl                    integer                                                      not null,
    condition_enabled         boolean                  default false                       not null,
    condition_start_timestamp timestamp with time zone default now()                       not null,
    condition_end_timestamp   timestamp with time zone default (now() + '1 day'::interval) not null,
    created_at                timestamp with time zone default now()                       not null,
    created_by                varchar                                                      not null,
    updated_at                timestamp with time zone,
    updated_by                varchar,
    constraint master_promo_condition_3pl_pk
        primary key (promo_id, id_3pl)
);

create index master_promo_condition_3pl_condition_enabled_condition_start_ti
    on master_promo_condition_3pl (condition_enabled, condition_start_timestamp, condition_end_timestamp);

create table master_promo_voucher
(
    promo_id                bigint                                                       not null
        constraint master_promo_voucher_master_promo_promo_id_fk
            references master_promo,
    voucher_code            varchar                                                      not null,
    voucher_enabled         boolean                  default false                       not null,
    voucher_start_timestamp timestamp with time zone default now()                       not null,
    voucher_end_timestamp   timestamp with time zone default (now() + '1 day'::interval) not null,
    created_at              timestamp with time zone default now()                       not null,
    created_by              varchar                                                      not null,
    updated_at              timestamp with time zone,
    updated_by              varchar,
    constraint master_promo_voucher_pk
        primary key (promo_id, voucher_code)
);

create index active_voucher_idx
    on master_promo_voucher (voucher_enabled, voucher_start_timestamp, voucher_end_timestamp);

create unique index unique_voucher_code
    on master_promo_voucher (voucher_code);