SELECT
    d.Department,
    j.JobRole,
    COUNT(CASE WHEN f.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
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