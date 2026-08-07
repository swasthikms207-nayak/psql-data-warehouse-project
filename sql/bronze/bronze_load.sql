--Loading raw CRM and ERP csv data into the bronze layer.
--Data is loaded without transformation so that the original source is preserved.

COPY BRONZE.crm_cust_info
(
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
)
FROM 'D:/postgreSQL-DATA-WAREHOUSE/data/source_crm/crm_cust_info.csv'
WITH(
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

COPY BRONZE.crm_prd_info
(
    prd_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
FROM 'D:/postgreSQL-DATA-WAREHOUSE/data/source_crm/crm_prd_info.csv'
WITH(
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

COPY BRONZE.crm_sales_details
(
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt ,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)
FROM 'D:/postgreSQL-DATA-WAREHOUSE/data/source_crm/crm_sales_details.csv'
WITH(
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

COPY BRONZE.erp_cust_az12
(
    CID,
    BDATE,
    GEN
)
FROM 'D:/postgreSQL-DATA-WAREHOUSE/data/source_erp/erp_CUST_AZ12.csv'
WITH(
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

COPY BRONZE.erp_loc_a101
(
    CID,
    CNTRY
)
FROM 'D:/postgreSQL-DATA-WAREHOUSE/data/source_erp/erp_LOC_A101.csv'
WITH(
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

COPY BRONZE.erp_px_cat_g1v2
(
    ID,
    CAT,
    SUBCAT,
    MAINTENANCE
)
FROM 'D:/postgreSQL-DATA-WAREHOUSE/data/source_erp/erp_PX_CAT_G1V2.csv'
WITH(
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);


