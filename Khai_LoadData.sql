-- Databricks notebook source
CREATE SCHEMA IF NOT EXISTS KHAI_EMPLOYEEDB;

-- COMMAND ----------

USE SCHEMA KHAI_EMPLOYEEDB;

-- COMMAND ----------

-- MAGIC %scala
-- MAGIC import scala.sys.process._
-- MAGIC 
-- MAGIC // Choose a name for your resulting table in Databricks
-- MAGIC var tableName = "Employee_data"
-- MAGIC 
-- MAGIC // Replace this URL with the one from your Google Spreadsheets
-- MAGIC // Click on File --> Publish to the Web --> Option CSV and copy the URL
-- MAGIC var url = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQtxKqRV3X9s4L60_CN5usNiD5SKAAdZHuqQGUIKsATflor6qEsPoh-GdLUY3jopDnsERY9pQSHIijW/pub?output=csv"
-- MAGIC 
-- MAGIC var localpath = "/tmp/" + tableName + ".csv"
-- MAGIC dbutils.fs.rm("file:" + localpath)
-- MAGIC "wget -O " + localpath + " " + url !!
-- MAGIC 
-- MAGIC dbutils.fs.mkdirs("dbfs:/datasets/gsheets")
-- MAGIC dbutils.fs.cp("file:" + localpath, "dbfs:/datasets/gsheets")
-- MAGIC 
-- MAGIC sqlContext.sql("drop table if exists " + tableName)
-- MAGIC var df = spark.read.option("header", "true").option("inferSchema", "true").csv("/datasets/gsheets/" + tableName + ".csv");
-- MAGIC 
-- MAGIC df.write.saveAsTable(tableName);

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC select * from Employee_data

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE EMPLOYEE(
-- MAGIC emId string,
-- MAGIC name string,
-- MAGIC gender string,
-- MAGIC email string,
-- MAGIC companyEmail string,
-- MAGIC phone string,
-- MAGIC faxNumber string,
-- MAGIC bankAccountNumber string,
-- MAGIC citizenIdentification string,
-- MAGIC roleId string,
-- MAGIC roleName string,
-- MAGIC departmentId string,
-- MAGIC University string,
-- MAGIC birthday date,
-- MAGIC startDay date,
-- MAGIC officialDay date,
-- MAGIC projectId string,
-- MAGIC dateCreated date,
-- MAGIC dateModified date
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC show create table EMPLOYEE

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into EMPLOYEE
-- MAGIC select distinct EmpID, Name, Gender, EmpEmail, CompanyEmail, EmpPhone, FaxNumber, BankAccountNumber, CitizenIdentification, RoleID, RoleName, DepID, University, Birthday, StartDay, OfficialDay, ProjectID, DateCreated, DateModified
-- MAGIC from Employee_data

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC select * from EMPLOYEE

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE SALARY(
-- MAGIC emId string,
-- MAGIC baseSalary int,
-- MAGIC grossSalary int,
-- MAGIC netSalary int
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into SALARY
-- MAGIC select EmpID, BaseSalary, GrossSalary, NetSalary
-- MAGIC from Employee_data

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC select * from SALARY

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE CONTRACT(
-- MAGIC emId string,
-- MAGIC contractStatus string,
-- MAGIC contractStartDay date,
-- MAGIC contractEndDay date
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into CONTRACT
-- MAGIC select distinct EmpID, ContractStatus, ContractStartDay, ContractEndDay
-- MAGIC from Employee_data

-- COMMAND ----------

-- MAGIC %sql 
-- MAGIC select * from CONTRACT

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE WORKINGMODEL(
-- MAGIC emId string,
-- MAGIC workingModel string,
-- MAGIC effort int,
-- MAGIC time string
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into WORKINGMODEL
-- MAGIC select distinct EmpID, WorkingModel, Effort, WorkingTime
-- MAGIC from Employee_data

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC select * from WORKINGMODEL

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE BANK(
-- MAGIC bankAccountNumber string,
-- MAGIC emId string,
-- MAGIC bankName string
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into BANK
-- MAGIC select distinct BankAccountNumber, EmpID, BankName
-- MAGIC from Employee_data

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC select * from BANK

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE DEPARTMENT(
-- MAGIC depId string,
-- MAGIC DepName string,
-- MAGIC location string
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into DEPARTMENT
-- MAGIC select distinct DepID, Department, DepLocation
-- MAGIC from Employee_data

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC select * from DEPARTMENT

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE PROJECT(
-- MAGIC projectId string,
-- MAGIC projectName string,
-- MAGIC projectManager string,
-- MAGIC projectStartDay date,
-- MAGIC projectEndDay date,
-- MAGIC projectStatus string,
-- MAGIC projectBudget int
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into PROJECT
-- MAGIC select distinct ProjectID, ProjectName, ProjectManager, ProjectStartDay, ProjectEndDay, ProjectStatus, ProjectBudget
-- MAGIC from Employee_data

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC select * from PROJECT

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE CV(
-- MAGIC emId string,
-- MAGIC linkCv string
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into CV
-- MAGIC select distinct EmpID, LinkCV
-- MAGIC from Employee_data

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC select * from CV

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC CREATE OR REPLACE TABLE ROLE (
-- MAGIC roleId string,
-- MAGIC roleName string
-- MAGIC )

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC insert into ROLE
-- MAGIC select distinct RoleID, RoleName
-- MAGIC from Employee_data

-- COMMAND ----------

select * from ROLE

-- COMMAND ----------


