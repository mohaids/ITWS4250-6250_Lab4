// STEP 1: Create Disease Nodes
MERGE (:Disease {name: 'Malaria', pathogen: 'Plasmodium', vector: 'Anopheles Mosquito'});
MERGE (:Disease {name: 'Dengue', pathogen: 'Dengue Virus', vector: 'Aedes Mosquito'});
MERGE (:Disease {name: 'Chikungunya', pathogen: 'Chikungunya Virus', vector: 'Aedes Mosquito'});

// STEP 2: Create Administrative Hierarchy 
// Create Countries (Admin_1)
MERGE (india:Admin_1 {name: 'India'});
MERGE (brazil:Admin_1 {name: 'Brazil'});
MERGE (nigeria:Admin_1 {name: 'Nigeria'});

// Create States/Districts (Admin_2)
MERGE (tamil_nadu:Admin_2 {name: 'Tamil Nadu'});
MERGE (sao_paulo_state:Admin_2 {name: 'São Paulo'});
MERGE (rio_state:Admin_2 {name: 'Rio de Janeiro'});
MERGE (lagos_state:Admin_2 {name: 'Lagos'});

// Connect Admin_2 to Admin_1 countries
MATCH (india:Admin_1 {name: 'India'})
MATCH (brazil:Admin_1 {name: 'Brazil'})
MATCH (nigeria:Admin_1 {name: 'Nigeria'})
MATCH (tamil_nadu:Admin_2 {name: 'Tamil Nadu'})
MATCH (sao_paulo_state:Admin_2 {name: 'São Paulo'})
MATCH (rio_state:Admin_2 {name: 'Rio de Janeiro'})
MATCH (lagos_state:Admin_2 {name: 'Lagos'})
MERGE (tamil_nadu)-[:IS_PART_OF]->(india)
MERGE (sao_paulo_state)-[:IS_PART_OF]->(brazil)
MERGE (rio_state)-[:IS_PART_OF]->(brazil)
MERGE (lagos_state)-[:IS_PART_OF]->(nigeria);

// Create Cities/Counties (Admin_3)
MERGE (chennai:Admin_3 {name: 'Chennai'});
MERGE (coimbatore:Admin_3 {name: 'Coimbatore'});
MERGE (sao_paulo_city:Admin_3 {name: 'São Paulo'});
MERGE (rio_city:Admin_3 {name: 'Rio de Janeiro'});
MERGE (ikeja:Admin_3 {name: 'Ikeja'});

// Connect Admin_3 to Admin_2 states
MATCH (chennai:Admin_3 {name: 'Chennai'})
MATCH (coimbatore:Admin_3 {name: 'Coimbatore'})
MATCH (sao_paulo_city:Admin_3 {name: 'São Paulo'})
MATCH (rio_city:Admin_3 {name: 'Rio de Janeiro'})
MATCH (ikeja:Admin_3 {name: 'Ikeja'})
MATCH (tamil_nadu:Admin_2 {name: 'Tamil Nadu'})
MATCH (sao_paulo_state:Admin_2 {name: 'São Paulo'})
MATCH (rio_state:Admin_2 {name: 'Rio de Janeiro'})
MATCH (lagos_state:Admin_2 {name: 'Lagos'})
MERGE (chennai)-[:IS_PART_OF]->(tamil_nadu)
MERGE (coimbatore)-[:IS_PART_OF]->(tamil_nadu)
MERGE (sao_paulo_city)-[:IS_PART_OF]->(sao_paulo_state)
MERGE (rio_city)-[:IS_PART_OF]->(rio_state)
MERGE (ikeja)-[:IS_PART_OF]->(lagos_state);

// STEP 3: Create Case Data Relationships 
// 1. Chennai - Dengue
MATCH (city:Admin_3 {name: 'Chennai'}), (disease:Disease {name: 'Dengue'})
CREATE (city)-[:HAS_CASES_OF {case_count: 500, date_reported: date('2024-10-25')}]->(disease);

// 2. Coimbatore - Malaria
MATCH (city:Admin_3 {name: 'Coimbatore'}), (disease:Disease {name: 'Malaria'})
CREATE (city)-[:HAS_CASES_OF {case_count: 250, date_reported: date('2024-10-25')}]->(disease);

// 3. São Paulo - Chikungunya
MATCH (city:Admin_3 {name: 'São Paulo'}), (disease:Disease {name: 'Chikungunya'})
CREATE (city)-[:HAS_CASES_OF {case_count: 120, date_reported: date('2024-10-25')}]->(disease);

// 4. Rio de Janeiro - Dengue
MATCH (city:Admin_3 {name: 'Rio de Janeiro'}), (disease:Disease {name: 'Dengue'})
CREATE (city)-[:HAS_CASES_OF {case_count: 800, date_reported: date('2024-10-25')}]->(disease);

// 5. Ikeja - Malaria
MATCH (city:Admin_3 {name: 'Ikeja'}), (disease:Disease {name: 'Malaria'})
CREATE (city)-[:HAS_CASES_OF {case_count: 1500, date_reported: date('2024-10-25')}]->(disease);