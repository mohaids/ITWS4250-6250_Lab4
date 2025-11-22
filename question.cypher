MATCH (country:Admin_1)<-[:IS_PART_OF*]-(city:Admin_3)-[r:HAS_CASES_OF]->(disease:Disease)
RETURN country.name AS Country, SUM(r.case_count) AS TotalCases
ORDER BY TotalCases DESC;