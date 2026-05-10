# HR Attrition Case Study

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

## Dashboard
<img width="1045" height="740" alt="image" src="https://github.com/user-attachments/assets/64648ace-bde5-45eb-bb25-015a86406877" />
<img width="1316" height="742" alt="image" src="https://github.com/user-attachments/assets/12e2c581-3d61-4c2a-87c3-7e34b1ab5ab6" />

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
```

```DAX
Attrition Count =
VAR LeftEmployees =
    CALCULATE(
        COUNTROWS(FactEmployee),
        FactEmployee[Attrition] = "Yes"
    )
RETURN
    LeftEmployees
```

```DAX
Attrition Rate =
VAR LeftEmployees = [Attrition Count]
VAR TotalEmp = [Total Employees]
RETURN
    DIVIDE(LeftEmployees, TotalEmp)
```

```DAX
Average Monthly Income =
VAR AvgIncome =
    AVERAGE(FactEmployee[MonthlyIncome])
RETURN
    AvgIncome
```

Other measures include:

- Active Employees
- Average Age
- Average Years at Company
- Average Total Working Years
- Overtime Attrition Rate
- Income Gap between Active and Attrition Employees

## Outlier and Trend Analysis

Outliers were identified using the IQR method for key numerical HR variables such as:

- Monthly Income
- Years Since Last Promotion
- Years at Company
- Total Working Years
- Number of Companies Worked
- Training Times Last Year

Outliers were not removed because they represent meaningful employee segments, such as senior employees, high-income employees, long-tenure employees, or employees with delayed promotions.

The dashboard compares attrition rate between normal and outlier groups to understand whether these employee segments show different attrition behavior.

Trend analysis was performed across:

- Department
- Job Role
- Overtime
- Income Band
- Experience Level
- Years at Company
- Business Travel

## Python Experience Level Classification

Python was used to classify employees into experience levels based on total working years:

- Junior: less than 5 years
- Mid: 5 to 9 years
- Senior: 10 or more years

```python
df["ExperienceLevel"] = df["TotalWorkingYears"].apply(
    lambda x: "Junior" if x < 5 else "Mid" if x <= 9 else "Senior"
)

experience_summary = df["ExperienceLevel"].value_counts().reset_index()
experience_summary.columns = ["ExperienceLevel", "EmployeeCount"]

experience_summary = experience_summary.set_index("ExperienceLevel").loc[
    ["Junior", "Mid", "Senior"]
].reset_index()

experience_summary
```

### Experience Level Summary

| ExperienceLevel | EmployeeCount |
|---|---:|
| Junior | 228 |
| Mid | 493 |
| Senior | 749 |

## SQL Query

The following SQL query demonstrates how the employee fact table joins with the Department and Job Role dimension tables.

```sql
SELECT
    d.Department,
    j.JobRole,
    SUM(f.AttritionFlag) AS AttritionCount,
    AVG(f.MonthlyIncome) AS AvgMonthlyIncome
FROM FactEmployee f
JOIN DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
JOIN DimJobRole j
    ON f.JobRoleKey = j.JobRoleKey
GROUP BY
    d.Department,
    j.JobRole
ORDER BY
    AttritionCount DESC;
```

This query calculates attrition count and average monthly income for each department and job role.

## Dashboard Pages

The Power BI report includes dashboards focused on:

### Executive Overview

- Total Employees
- Attrition Count
- Attrition Rate
- Average Monthly Income
- Average Age
- Average Tenure
- Attrition by Department
- Attrition by Job Role
- Attrition by Overtime

### Attrition Drivers and Outliers

- Attrition Rate by Experience Level
- Attrition Rate by Income Band
- Attrition Rate by Years at Company
- Income Outlier Impact
- Tenure Outlier Impact
- Promotion Delay Outlier Impact

## Key Insights

- Attrition rate is more meaningful than attrition count because departments and job roles have different employee populations.
- Research & Development may show the highest attrition count due to its larger workforce size, while Sales may show higher relative attrition risk.
- Junior employees show higher attrition risk compared with Mid and Senior employees.
- High-income outlier employees show lower attrition, suggesting that seniority and compensation are associated with stronger retention.
- Overtime and lower income segments should be reviewed as potential attrition risk areas.
- Long-tenure employees tend to show stronger retention compared with earlier-tenure employees.

## Recommendations

- Prioritize retention actions for high-risk departments and job roles.
- Review workload and overtime policies to reduce burnout-related attrition.
- Strengthen onboarding and engagement programs for Junior employees.
- Review compensation competitiveness for lower and mid-income employees.
- Monitor employees with long promotion delays and provide clearer career progression paths.
- Use department and job-role level attrition rate, not only attrition count, when making HR decisions.

## Tools Used

- Power BI
- DAX
- Power Query
- Python
- Pandas
- SQL

## Repository Contents

This repository contains:

- Power BI report file
- Python code for experience level classification
- SQL query demonstration
- Presentation or documentation files
- Supporting analysis outputs

## Author

Amany Gaber
