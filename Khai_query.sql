-- Databricks notebook source
USE SCHEMA KHAI_EMPLOYEEDB;

-- COMMAND ----------

/*Thống kê số nhân viên mới theo tháng*/
SELECT COUNT(EMPLOYEE.emId)
FROM EMPLOYEE
WHERE YEAR(startDay)=2022 AND MONTH(StartDay) = 7;

-- COMMAND ----------

/*Thống kê số nhân viên mới theo  tuần*/
SELECT COUNT(EMPLOYEE.emId)
FROM EMPLOYEE
WHERE YEAR(startDay)=2022 AND MONTH(StartDay)=7 AND DAY(StartDay) BETWEEN 10 AND 20;

-- COMMAND ----------

/*Thống kê số tổng số nhân viên*/
SELECT COUNT(EMPLOYEE.emId)
FROM EMPLOYEE;

-- COMMAND ----------

/*Thống kê số nhân viên thử việc*/
SELECT COUNT(CONTRACT.emId)
FROM CONTRACT
WHERE contractStatus = 'Probation';

-- COMMAND ----------

/*Thống kê số nhân viên chính thức*/
SELECT COUNT(CONTRACT.emId)
FROM CONTRACT
WHERE NOT ContractStatus = 'Probation';

-- COMMAND ----------

/*Cơ cấu nhân sự theo phòng ban*/
SELECT DEPARTMENT.depName, COUNT(EMPLOYEE.emId)
FROM DEPARTMENT, EMPLOYEE
WHERE DEPARTMENT.depId = EMPLOYEE.departmentId 
GROUP BY DEPARTMENT.depName;

-- COMMAND ----------

/*Cơ cấu nhân sự theo phòng ban đến ngày hiện tại*/
SELECT DEPARTMENT.depName, COUNT(EMPLOYEE.emId)
FROM DEPARTMENT, EMPLOYEE, CONTRACT
WHERE DEPARTMENT.depId = EMPLOYEE.departmentId AND CONTRACT.emId = EMPLOYEE.emId AND CONTRACT.ContractEndDay > current_date()
GROUP BY DEPARTMENT.depName;

-- COMMAND ----------

/*Cơ cấu nhân sự theo vị trí*/
SELECT ROLE.RoleName, COUNT(EMPLOYEE.emId)
FROM ROLE, EMPLOYEE
WHERE ROLE.roleId = EMPLOYEE.roleId 
GROUP BY ROLE.roleName;

-- COMMAND ----------

/*Cơ cấu nhân sự theo phòng ban đến ngày hiện tại*/
SELECT DEPARTMENT.depName, COUNT(EMPLOYEE.emId)
FROM DEPARTMENT, EMPLOYEE, CONTRACT
WHERE DEPARTMENT.depId = EMPLOYEE.departmentId AND CONTRACT.emId = EMPLOYEE.emId AND CONTRACT.contractEndDay >= current_date()
GROUP BY DEPARTMENT.depName;

-- COMMAND ----------

/*Cơ cấu nhân sự theo vị trí*/
SELECT ROLE.roleName, COUNT(EMPLOYEE.emId)
FROM ROLE, EMPLOYEE
WHERE ROLE.roleId = EMPLOYEE.roleId 
GROUP BY ROLE.roleName;

-- COMMAND ----------

/*Cơ cấu nhân sự theo vị trí đến ngày hiện tại*/
SELECT  ROLE.roleName, COUNT(EMPLOYEE.emId)
FROM ROLE, EMPLOYEE, CONTRACT
WHERE ROLE.roleId = EMPLOYEE.roleId AND CONTRACT.emId = EMPLOYEE.emId AND CONTRACT.contractEndDay > current_date()
GROUP BY ROLE.roleName;

-- COMMAND ----------

/*Thống kê hợp đồng theo loại - tất cả đơn vị*/
SELECT CONTRACT.contractStatus, COUNT(CONTRACT.emId)
FROM CONTRACT, EMPLOYEE
WHERE CONTRACT.emId = EMPLOYEE.emId 
GROUP BY CONTRACT.contractStatus;

-- COMMAND ----------

/*Thống kê hợp đồng theo loại - tất cả đơn vị - đến ngày hiện tại*/
SELECT CONTRACT.contractStatus, COUNT(CONTRACT.emId)
FROM CONTRACT, EMPLOYEE
WHERE CONTRACT.emId = EMPLOYEE.emId AND CONTRACT.contractStartDay < current_date()
GROUP BY CONTRACT.contractStatus;

-- COMMAND ----------

/*Thống kê hợp đồng theo loại - theo từng đơn vị*/
SELECT CONTRACT.contractStatus,DEPARTMENT.depName,  COUNT(CONTRACT.emId)
FROM CONTRACT, EMPLOYEE, DEPARTMENT
WHERE CONTRACT.emId = EMPLOYEE.emId AND DEPARTMENT.depID = EMPLOYEE.departmentId
GROUP BY CONTRACT.contractStatus, DEPARTMENT.depName;

-- COMMAND ----------

/*Thống kê hợp đồng theo loại - theo từng đơn vị - đến ngày hiện tại*/
SELECT CONTRACT.contractStatus, DEPARTMENT.depName, COUNT(CONTRACT.emId)
FROM CONTRACT, EMPLOYEE, DEPARTMENT
WHERE CONTRACT.emId = EMPLOYEE.emId AND DEPARTMENT.depId = EMPLOYEE.departmentId AND CONTRACT.contractStartDay < current_date()
GROUP BY CONTRACT.contractStatus, DEPARTMENT.depName;

-- COMMAND ----------

/*Biến động nhân sự - đến năm hiện tại*/
SELECT YEAR(CONTRACT.contractStartDay) AS YEARNOW, COUNT(CASE WHEN CONTRACT.contractEndDay < current_date() then 1 end) AS EndEmp,COUNT(CASE WHEN CONTRACT.contractStartDay < current_date() then 1 end) AS NewEmp
FROM EMPLOYEE, CONTRACT
WHERE  CONTRACT.emId = EMPLOYEE.emId  AND  YEAR(CONTRACT.contractStartDay) < year(current_date())
GROUP BY YEAR(CONTRACT.contractStartDay);

-- COMMAND ----------

/*Biến động nhân sự theo phòng ban - đến năm hiện tại*/
SELECT YEAR(CONTRACT.contractStartDay) AS YEARNOW, DEPARTMENT.DepName, COUNT(CASE WHEN CONTRACT.contractEndDay < current_date() then 1 end) AS EndEmp,COUNT(CASE WHEN CONTRACT.contractStartDay < current_date() then 1 end) AS NewEmp
FROM EMPLOYEE, CONTRACT, DEPARTMENT
WHERE  DEPARTMENT.depId = EMPLOYEE.departmentId AND CONTRACT.emId = EMPLOYEE.emId  AND  YEAR(CONTRACT.contractStartDay) < year(current_date())
GROUP BY YEAR(CONTRACT.contractStartDay), DEPARTMENT.depName;

-- COMMAND ----------

/*Biến động nhân sự theo vị trí - đến năm hiện tại*/
SELECT YEAR(CONTRACT.contractStartDay) AS YEARNOW, ROLE.roleName, COUNT(CASE WHEN CONTRACT.contractEndDay < current_date() then 1 end) AS EndEmp,COUNT(CASE WHEN CONTRACT.contractStartDay < current_date() then 1 end) AS NewEmp
FROM EMPLOYEE, CONTRACT, ROLE
WHERE  ROLE.roleId = EMPLOYEE.roleId AND CONTRACT.emId = EMPLOYEE.emId  AND  YEAR(CONTRACT.contractStartDay) < year(current_date())
GROUP BY YEAR(CONTRACT.contractStartDay), ROLE.roleName;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Base salary) - Đến ngày hiện tại*/
SELECT SUM(SALARY.baseSalary)
FROM SALARY;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Base salary) theo từng đơn vị - Đến ngày hiện tại*/
SELECT DEPARTMENT.depName, SUM(SALARY.baseSalary) AS SALARY
FROM SALARY, EMPLOYEE, DEPARTMENT
WHERE SALARY.emId = EMPLOYEE.emId AND EMPLOYEE.departmentId = DEPARTMENT.depId
GROUP BY DEPARTMENT.depName;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Base salary) theo từng vị trí - Đến ngày hiện tại*/
SELECT ROLE.roleName, SUM(SALARY.baseSalary) AS SALARY
FROM SALARY, EMPLOYEE, ROLE
WHERE SALARY.emId = EMPLOYEE.emId AND EMPLOYEE.roleId = ROLE.roleId
GROUP BY ROLE.roleName;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Gross salary) - Đến ngày hiện tại*/
SELECT SUM(SALARY.grossSalary)
FROM SALARY;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Gross salary) theo từng đơn vị - Đến ngày hiện tại*/
SELECT DEPARTMENT.depName, SUM(SALARY.grossSalary) AS salary
FROM SALARY, EMPLOYEE, DEPARTMENT
WHERE SALARY.emId = EMPLOYEE.emId AND EMPLOYEE.departmentId = DEPARTMENT.depID
GROUP BY DEPARTMENT.depName;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Gross salary) theo từng vị trí - Đến ngày hiện tại*/
SELECT ROLE.roleName, SUM(SALARY.grossSalary) AS salary
FROM SALARY, EMPLOYEE, ROLE
WHERE SALARY.emId = EMPLOYEE.emId AND EMPLOYEE.roleId = ROLE.roleId
GROUP BY ROLE.roleName;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Net salary) - Đến ngày hiện tại*/
SELECT SUM(SALARY.netSalary)
FROM SALARY;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Net salary) theo từng đơn vị - Đến ngày hiện tại*/
SELECT DEPARTMENT.depName, SUM(SALARY.netSalary) AS salary
FROM SALARY, EMPLOYEE, DEPARTMENT
WHERE SALARY.emId = EMPLOYEE.emId AND EMPLOYEE.departmentId = DEPARTMENT.depId
GROUP BY DEPARTMENT.depName;

-- COMMAND ----------

/*Tổng chi phí lương cơ bản (Net salary) theo từng vị trí - Đến ngày hiện tại*/
SELECT ROLE.roleName, SUM(SALARY.netSalary) AS salary
FROM SALARY, EMPLOYEE, ROLE
WHERE SALARY.emId = EMPLOYEE.emId AND EMPLOYEE.roleId = ROLe.roleId
GROUP BY ROLE.roleName;

-- COMMAND ----------

/*Thống kê hợp đồng theo loại*/
SELECT CONTRACT.contractStatus , count(CONTRACT.emId)
FROM CONTRACT
GROUP BY CONTRACT.contractStatus;

-- COMMAND ----------

/*Thống kê hợp đồng - sắp hết hạn*/
SELECT CONTRACT.contractStatus , count(CONTRACT.emId)
FROM CONTRACT
WHERE datediff(CONTRACT.contractEndDay, current_date()) < 45
GROUP BY CONTRACT.contractStatus;

-- COMMAND ----------

/*Thống kê hợp đồng hết hạn*/
SELECT CONTRACT.contractStatus , count(CONTRACT.emId)
FROM CONTRACT
WHERE datediff(CONTRACT.contractEndDay, current_date()) > 0
GROUP BY CONTRACT.ContractStatus;

-- COMMAND ----------

/*Thống kê nhân viên theo giới tính*/
SELECT EMPLOYEE.gender, count(EMPLOYEE.emId)
FROM EMPLOYEE
GROUP BY EMPLOYEE.gender;

-- COMMAND ----------

/*Thống kê nhân viên theo thâm niên*/
SELECT count(CONTRACT.emId)
FROM CONTRACT
WHERE datediff(CONTRACT.contractEndDay, current_date()) < 0 AND ROUND(datediff(current_date(), CONTRACT.ContractStartDay)/365, 0) BETWEEN 0 AND 1;


-- COMMAND ----------

/*Thống kê hợp đồng hết hạn chưa tái kí*/
SELECT CONTRACT.contractStatus , count(CONTRACT.emId)
FROM CONTRACT
WHERE datediff(CONTRACT.contractEndDay, current_date) > 0
GROUP BY CONTRACT.contractStatus;

-- COMMAND ----------

/*Thống kê nhân viên theo vị trí*/
SELECT DEPARTMENT.location, count(EMPLOYEE.emId)
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.departmentId = DEPARTMENT.depId
GROUP BY DEPARTMENT.location;

-- COMMAND ----------

/*Tổng số dự án*/
SELECT count(PROJECT.projectId)
FROM PROJECT;

-- COMMAND ----------

/*Số nhân sự theo từng dự án*/
SELECT PROJECT.projectName, count(EMPLOYEE.emId)
FROM PROJECT, EMPLOYEE
WHERE PROJECT.projectId = EMPLOYEE.projectId
GROUP BY PROJECT.projectName;

-- COMMAND ----------

/*Số nhân sự theo từng dự án theo từng vị trí*/
SELECT PROJECT.projectName, ROLE.roleName, count(EMPLOYEE.emId)
FROM PROJECT, EMPLOYEE, ROLE
WHERE PROJECT.projectID = EMPLOYEE.projectID AND EMPLOYEE.roleID = ROLE.roleID
GROUP BY PROJECT.projectName, ROLE.roleName ;

-- COMMAND ----------

/*Tổng chi phí nhân sự (theo lương gross + thưởng) theo từng dự án*/
SELECT PROJECT.projectName, sum(SALARY.grossSalary), count(EMPLOYEE.emId)
FROM PROJECT, EMPLOYEE, SALARY
WHERE PROJECT.projectId = EMPLOYEE.projectId AND EMPLOYEE.emId = SALARY.emId
GROUP BY PROJECT.projectName ;

-- COMMAND ----------

/*Tổng số nhân sự làm việc Online - theo từng dự án*/
SELECT PROJECT.projectName, count(EMPLOYEE.emId)
FROM PROJECT, EMPLOYEE, WORKINGMODEL
WHERE PROJECT.projectId = EMPLOYEE.projectId AND EMPLOYEE.emId = WORKINGMODEL.emId AND WORKINGMODEL.Time = 'Online'
GROUP BY PROJECT.projectName ;

-- COMMAND ----------

/*Tổng số nhân sự làm việc Offline - theo từng dự án*/
SELECT PROJECT.projectName, count(EMPLOYEE.emId)
FROM PROJECT, EMPLOYEE, WORKINGMODEL
WHERE PROJECT.projectId = EMPLOYEE.projectId AND EMPLOYEE.emId = WORKINGMODEL.emId AND WORKINGMODEL.Time = 'Offline'
GROUP BY PROJECT.projectName ;

-- COMMAND ----------

/*Tổng số nhân sự làm việc Hybrid - theo từng dự án*/
SELECT PROJECT.projectName, count(EMPLOYEE.emId)
FROM PROJECT, EMPLOYEE, WORKINGMODEL
WHERE PROJECT.projectID = EMPLOYEE.projectID AND EMPLOYEE.emId = WORKINGMODEL.emId AND WORKINGMODEL.Time = 'Hybrid'
GROUP BY PROJECT.projectName ;

-- COMMAND ----------

/*Tổng số nhân sự làm việc Full time/Part time*/
SELECT WORKINGMODEL.workingModel, count(EMPLOYEE.emId)
FROM EMPLOYEE, WORKINGMODEL
WHERE EMPLOYEE.emId = WORKINGMODEL.emId 
GROUP BY WORKINGMODEL.WorkingModel;

-- COMMAND ----------

/*Tổng số nhân viên theo effort */
SELECT WORKINGMODEL.Effort, count(EMPLOYEE.emId)
FROM EMPLOYEE, WORKINGMODEL
WHERE EMPLOYEE.emId = WORKINGMODEL.emId 
GROUP BY WORKINGMODEL.Effort ;

-- COMMAND ----------

SELECT SUM(SALARY.baseSalary) as sumSalary, PROJECT.projectName
FROM PROJECT, SALARY, EMPLOYEE
WHERE PROJECT.projectId = EMPLOYEE.projectId AND SALARY.emId = EMPLOYEE.emId
GROUP BY PROJECT.projectName ;

-- COMMAND ----------


