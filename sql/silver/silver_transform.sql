/*
========================================================================================
Procedure : Load Bronze Layer
Purpose   : Loading raw CRM and ERP csv data into the bronze layer without transforming
            to preserve the source data.
========================================================================================
*/

CREATE OR REPLACE PROCEDURE SILVER.load_silver()
LANGUAGE plpgsql
AS $$
DECLARE 
start_time TIMESTAMP;
end_time TIMESTAMP;
rows_loaded INTEGER;
BEGIN
start_time := clock_timestamp();
RAISE NOTICE
'======================================================================================';
RAISE NOTICE 'Loading Silver Layer';
RAISE NOTICE 'Start Time: %',start_time;
RAISE NOTICE
'======================================================================================';
RAISE NOTICE 'Loading crm_cust_info...';

TRUNCATE TABLE SILVER.crm_cust_info;
INSERT INTO SILVER.crm_cust_info
(
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
)
SELECT 
cst_id :: INTEGER,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status))='S' THEN 'Single'
     WHEN UPPER(TRIM(cst_marital_status))='M' THEN 'Married'
     ELSE 'n/a'
END AS cst_marital_status,
CASE WHEN UPPER(TRIM(cst_gndr))='F' THEN 'Female'
     WHEN UPPER(TRIM(cst_gndr))='M' THEN 'Male'
     ELSE 'n/a'
END AS cst_gndr,
cst_create_date :: DATE
FROM(
    SELECT *,ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC)
 AS rn FROM BRONZE.crm_cust_info
       WHERE cst_id IS NOT NULL
)AS ranked 
WHERE rn=1;
GET DIAGNOSTICS rows_loaded = ROW_COUNT;
RAISE NOTICE 'Rows Loaded = %',rows_loaded;

RAISE NOTICE 'Loading crm_prd_info...';
TRUNCATE TABLE SILVER.crm_prd_info;
INSERT INTO SILVER.crm_prd_info
(
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT
prd_id :: INTEGER,
SUBSTRING(REPLACE(prd_key,'-','_'),1,5) AS cat_id,
SUBSTRING(prd_key,7,LENGTH(prd_key)) AS prd_key,
prd_nm,
prd_cost :: NUMERIC,
CASE
WHEN TRIM(prd_line)='R' THEN 'Road'
WHEN TRIM(prd_line)='M' THEN 'Mountain'
WHEN TRIM(prd_line)='S' THEN 'Other Sales'
WHEN TRIM(prd_line)='T' THEN 'Touring'
ELSE 'n/a'
END AS prd_line,
prd_start_dt :: DATE,
LEAD(prd_start_dt :: DATE) OVER(PARTITION BY prd_key ORDER BY prd_start_dt :: DATE):: DATE -1 AS prd_end_dt
FROM BRONZE.crm_prd_info;
GET DIAGNOSTICS rows_loaded = ROW_COUNT;
RAISE NOTICE 'Rows Loaded = %',rows_loaded;

RAISE NOTICE 'Loading crm_sales_details...';
TRUNCATE TABLE SILVER.crm_sales_details;
INSERT INTO SILVER.crm_sales_details
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
SELECT
sls_ord_num,
sls_prd_key,
sls_cust_id :: INTEGER,
CASE WHEN sls_order_dt::INTEGER=0 OR LENGTH(sls_order_dt)!=8 THEN NULL
     ELSE TO_DATE(sls_order_dt, 'YYYYMMDD')
END AS sls_order_dt,
CASE WHEN sls_ship_dt::INTEGER=0 OR LENGTH(sls_ship_dt)!=8 THEN NULL
     ELSE TO_DATE(sls_ship_dt, 'YYYYMMDD')
END AS sls_ship_dt,
CASE WHEN sls_due_dt::INTEGER=0 OR LENGTH(sls_due_dt)!=8 THEN NULL
     ELSE TO_DATE(sls_due_dt, 'YYYYMMDD')
END AS sls_due_dt,
CASE WHEN sls_sales::NUMERIC<=0 OR sls_sales IS NULL OR sls_sales::NUMERIC!=NULLIF(sls_quantity::INTEGER,0)*ABS(sls_price::NUMERIC)
THEN sls_quantity::INTEGER*ABS(sls_price::NUMERIC)
ELSE sls_sales::NUMERIC
END AS sls_sales,
sls_quantity::INTEGER,
CASE WHEN sls_price::NUMERIC<=0 OR sls_price IS NULL OR sls_price::NUMERIC!=ABS(sls_sales::NUMERIC)/sls_quantity::INTEGER
THEN ABS(sls_sales::NUMERIC)/NULLIF(sls_quantity::INTEGER,0)
ELSE sls_price::NUMERIC
END AS sls_price
FROM BRONZE.crm_sales_details;
GET DIAGNOSTICS rows_loaded = ROW_COUNT;
RAISE NOTICE 'Rows Loaded = %',rows_loaded;

RAISE NOTICE 'Loading erp_cust_az12...';
TRUNCATE TABLE SILVER.erp_cust_az12;
INSERT INTO SILVER.erp_cust_az12
(
    CID,
    BDATE,
    GEN
)
SELECT
CASE WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LENGTH(CID)) 
     ELSE CID
END AS CID,
CASE WHEN BDATE::DATE > CURRENT_DATE THEN NULL
     ELSE BDATE::DATE
END AS BDATE,
CASE WHEN UPPER(TRIM(GEN)) IN('F','FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(GEN)) IN('M','MALE') THEN 'Male'
     ELSE 'n/a'
END AS GEN
FROM BRONZE.erp_cust_az12;
GET DIAGNOSTICS rows_loaded = ROW_COUNT;
RAISE NOTICE 'Rows Loaded = %',rows_loaded;

RAISE NOTICE 'Loading erp_loc_a101...';
TRUNCATE TABLE SILVER.erp_loc_a101;
INSERT INTO SILVER.erp_loc_a101
(
CID,
CNTRY
)
SELECT
REPLACE(CID,'-','') AS CID,
CASE WHEN UPPER(TRIM(CNTRY)) IN ('USA','US') THEN 'United States'
     WHEN UPPER(TRIM(CNTRY))='DE' THEN 'Germany'
     WHEN UPPER(TRIM(CNTRY))='' OR CNTRY IS NULL THEN 'n/a'
     ELSE TRIM(CNTRY)
END AS CNTRY
FROM BRONZE.erp_loc_a101;
GET DIAGNOSTICS rows_loaded = ROW_COUNT;
RAISE NOTICE 'Rows Loaded = %',rows_loaded;

RAISE NOTICE 'Loading erp_px_cat_g1v2...';
TRUNCATE TABLE SILVER.erp_px_cat_g1v2;
INSERT INTO SILVER.erp_px_cat_g1v2
(
    ID,
    CAT,
    SUBCAT,
    MAINTENANCE
)
SELECT 
ID,
CAT,
SUBCAT,
MAINTENANCE
FROM BRONZE.erp_px_cat_g1v2;
GET DIAGNOSTICS rows_loaded = ROW_COUNT;
RAISE NOTICE 'Rows Loaded = %',rows_loaded;
end_time := clock_timestamp();

RAISE NOTICE
'======================================================================================';
RAISE NOTICE 'End Time = %',end_time;
RAISE NOTICE 'Load Duration = %',end_time-start_time;
RAISE NOTICE 
'======================================================================================';
EXCEPTION
WHEN OTHERS THEN
RAISE NOTICE 'Bronze Load Failed!';
RAISE NOTICE '%',SQLERRM;
RAISE;
END;
$$;


--Executing the procedure
CALL SILVER.load_silver();