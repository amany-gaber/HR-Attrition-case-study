## Project Overview

This project analyzes employee attrition using Power BI, Python, and SQL. The goal is to identify key employee segments associated with attrition and provide data-driven recommendations to support HR retention decisions.

The analysis focuses on attrition patterns across departments, job roles, overtime, income, experience level, tenure, and outlier employee groups.

## Business Problem

Employee attrition can increase hiring costs, reduce productivity, and lead to the loss of experienced talent. The business problem is to identify which employee groups are most associated with attrition and understand the key factors behind employee turnover so HR can take data-driven actions to improve retention.

## Business Question

Which employee segments have the highest attrition risk, and what actions can HR take to reduce employee turnover?

## Project Objectives

- Prepare a Power BI model using a star schema structure.
- Create DAX measures using variables to support business decision-making.
- Identify and analyze outliers and trends in attrition data.
- Develop clear and concise Power BI dashboards.
- Provide narrative insights and actionable HR recommendations.
- Demonstrate SQL joins between the employee fact table and dimension tables.
- Use Python to classify employees into experience levels.

## Dataset

The dataset contains employee-level HR information, including:

- Age
- Attrition
- Department
- Job Role
- Gender
- Monthly Income
- Business Travel
- Overtime
- Total Working Years
- Years at Company
- Years Since Last Promotion
- Job Satisfaction
- Work Life Balance
- Other HR-related attributes

Each row represents one employee.

## Power BI Star Schema

The original flat dataset was transformed into a star schema model.

### Fact Table

**FactEmployee**

The fact table contains employee-level numerical attributes, attrition indicators, and foreign keys to dimension tables.

Main fields include:

- EmployeeNumber
- Age
- Attrition
- AttritionFlag
- MonthlyIncome
- DistanceFromHome
- TotalWorkingYears
- YearsAtCompany
- YearsInCurrentRole
- YearsSinceLastPromotion
- TrainingTimesLastYear
- DepartmentKey
- JobRoleKey
- EducationFieldKey
- GenderKey
- MaritalStatusKey
- BusinessTravelKey
- OverTimeKey
- ExperienceLevelKey

### Dimension Tables

- **DimDepartment**
- **DimJobRole**
- **DimEducationField**
- **DimGender**
- **DimMaritalStatus**
- **DimBusinessTravel**
- **DimOverTime**
- **DimExperienceLevel**

The relationships are configured as one-to-many from each dimension table to the fact table using single-direction filtering.

## DAX Measures

Several DAX measures were created using variables to support HR decision-making.

Examples include:

```DAX
Total Employees =
VAR TotalEmp =
    COUNTROWS(FactEmployee)
RETURN
    TotalEmp
