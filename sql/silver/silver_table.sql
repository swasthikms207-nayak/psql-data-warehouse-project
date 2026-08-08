/*
========================================================================================
Procedure : Create Silver Tables
Purpose   : Creating tables in the Silver Layer,droping existing tables if they
            already exists.
========================================================================================
*/

DROP TABLE IF EXISTS SILVER.crm_cust_info;
CREATE TABLE SILVER.crm_cust_info
(
    cst_id INTEGER PRIMARY KEY,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status CHAR(1),
    cst_gndr CHAR(1),
    cst_create_date DATE,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.crm_prd_info;
CREATE TABLE SILVER.crm_prd_info
(
    prd_id INTEGER,
    prd_key VARCHAR(50) PRIMARY KEY,
    prd_nm VARCHAR(100),
    prd_cost NUMERIC(10,2),
    prd_line CHAR(1),
    prd_start_dt DATE,
    prd_end_dt DATE,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.crm_sales_details;
CREATE TABLE SILVER.crm_sales_details
(
    sls_ord_num VARCHAR(50) PRIMARY KEY,
    sls_prd_key VARCHAR(50),
    sls_cust_id INTEGER,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INTEGER,
    sls_quantity INTEGER,
    sls_price NUMERIC(10,2),
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.erp_cust_az12;
CREATE TABLE SILVER.erp_cust_az12
(
    CID VARCHAR(50) PRIMARY KEY,
    BDATE DATE,
    GEN VARCHAR(50),
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.erp_loc_a101;
CREATE TABLE SILVER.erp_loc_a101
(
    CID VARCHAR(50) PRIMARY KEY,
    CNTRY VARCHAR(50),
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.erp_px_cat_g1v2;
CREATE TABLE SILVER.erp_px_cat_g1v2
(
    ID VARCHAR(50) PRIMARY KEY,
    CAT VARCHAR(50),
    SUBCAT VARCHAR(50),
    MAINTENANCE VARCHAR(50),
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);