/*
========================================================================================
Procedure : Create Silver Tables
Purpose   : Create tables in the Silver layer, dropping existing tables if they
            already exist.
========================================================================================
*/

DROP TABLE IF EXISTS SILVER.crm_cust_info;
CREATE TABLE SILVER.crm_cust_info
(
    cst_id INTEGER NOT NULL,
    cst_key VARCHAR(50) NOT NULL,
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE NOT NULL,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.crm_prd_info;
CREATE TABLE SILVER.crm_prd_info
(
    prd_id INTEGER NOT NULL,
    cat_id VARCHAR(50) NOT NULL,
    prd_key VARCHAR(50) NOT NULL,
    prd_nm VARCHAR(100),
    prd_cost NUMERIC(10,2),
    prd_line VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.crm_sales_details;
CREATE TABLE SILVER.crm_sales_details
(
    sls_ord_num VARCHAR(50) NOT NULL,
    sls_prd_key VARCHAR(50) NOT NULL,
    sls_cust_id INTEGER NOT NULL,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales NUMERIC(10,2),
    sls_quantity INTEGER,
    sls_price NUMERIC(10,2),
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.erp_cust_az12;
CREATE TABLE SILVER.erp_cust_az12
(
    CID VARCHAR(50) NOT NULL,
    BDATE DATE,
    GEN VARCHAR(50),
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.erp_loc_a101;
CREATE TABLE SILVER.erp_loc_a101
(
    CID VARCHAR(50) NOT NULL,
    CNTRY VARCHAR(50),
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SILVER.erp_px_cat_g1v2;
CREATE TABLE SILVER.erp_px_cat_g1v2
(
    ID VARCHAR(50) NOT NULL,
    CAT VARCHAR(50),
    SUBCAT VARCHAR(50),
    MAINTENANCE VARCHAR(50),
    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

