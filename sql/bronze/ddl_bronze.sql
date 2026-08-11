/*
========================================================================================
Procedure : Create Bronze Tables
Purpose   : Create tables in the Bronze layer, dropping existing tables if they
            already exist.
========================================================================================
*/

DROP TABLE IF EXISTS BRONZE.crm_cust_info;
CREATE TABLE BRONZE.crm_cust_info
(
    cst_id TEXT,
    cst_key TEXT,
    cst_firstname TEXT,
    cst_lastname TEXT,
    cst_marital_status TEXT,
    cst_gndr TEXT,
    cst_create_date TEXT,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS BRONZE.crm_prd_info;
CREATE TABLE BRONZE.crm_prd_info
(
    prd_id TEXT,
    prd_key TEXT,
    prd_nm TEXT,
    prd_cost TEXT,
    prd_line TEXT,
    prd_start_dt TEXT,
    prd_end_dt TEXT,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS BRONZE.crm_sales_details;
CREATE TABLE BRONZE.crm_sales_details
(
    sls_ord_num TEXT,
    sls_prd_key TEXT,
    sls_cust_id TEXT,
    sls_order_dt TEXT,
    sls_ship_dt TEXT,
    sls_due_dt TEXT,
    sls_sales TEXT,
    sls_quantity TEXT,
    sls_price TEXT,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS BRONZE.erp_cust_az12;
CREATE TABLE BRONZE.erp_cust_az12
(
    CID TEXT,
    BDATE TEXT,
    GEN TEXT,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS BRONZE.erp_loc_a101;
CREATE TABLE BRONZE.erp_loc_a101
(
    CID TEXT,
    CNTRY TEXT,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS BRONZE.erp_px_cat_g1v2;
CREATE TABLE BRONZE.erp_px_cat_g1v2
(
    ID TEXT,
    CAT TEXT,
    SUBCAT TEXT,
    MAINTENANCE TEXT,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
