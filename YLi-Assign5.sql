-- Question 1
SELECT quantityOnHand
FROM item
WHERE itemDescription LIKE '%antibiotic%';

-- Question 2
SELECT volunteerName
FROM volunteer
WHERE volunteerTelephone NOT LIKE '2%'
AND volunteerName NOT LIKE '% Jones';

-- Question 3
SELECT DISTINCT v.volunteerName
FROM volunteer AS v
JOIN assignment AS a
    ON a.volunteerId = v.volunteerId
JOIN task AS t
    ON t.taskCode = a.taskCode
JOIN task_type AS tt
    ON tt.taskTypeId = t.taskTypeId
WHERE tt.taskTypeName = 'transporting';

-- Question 4
SELECT DISTINCT t.taskDescription
FROM task AS t
LEFT JOIN assignment AS a
    ON a.taskCode = t.taskCode
WHERE a.taskCode IS NULL;

--- Question 5
SELECT DISTINCT pt.packageTypeName
FROM package_type AS pt
JOIN package AS p
    ON p.packageTypeId = pt.packageTypeId
JOIN package_contents AS pc
    ON pc.packageId = p.packageId
JOIN item AS i
    ON i.itemId = pc.itemId
WHERE i.itemDescription LIKE '%bottle%';

-- Question 6
SELECT DISTINCT i.itemDescription
FROM item AS i
LEFT JOIN package_contents AS pc
    ON pc.itemId = i.itemId
WHERE pc.itemId IS NULL;

-- Question 7
SELECT DISTINCT t.taskDescription
FROM task AS t
JOIN assignment AS a
    ON a.taskCode = t.taskCode
JOIN volunteer AS v
    ON v.volunteerId = a.volunteerId
WHERE v.volunteerAddress LIKE '% NJ%';

-- Question 8
SELECT DISTINCT v.volunteerName
FROM volunteer AS v
JOIN assignment AS a
    ON a.volunteerId = v.volunteerId
WHERE a.startDateTime >= '2021-01-01'
AND a.startDateTime < '2021-07-01';

-- Question 9
SELECT DISTINCT v.volunteerName
FROM volunteer AS v
JOIN assignment AS a
    ON a.volunteerId = v.volunteerId
JOIN task AS t
    ON t.taskCode = a.taskCode
JOIN package AS p
    ON p.taskCode = t.taskCode
JOIN package_contents AS pc
    ON pc.packageId = p.packageId
JOIN item AS i
    ON i.itemId = pc.itemId
WHERE i.itemDescription LIKE '%spam%';

-- Question 10
SELECT DISTINCT i.itemDescription
FROM item AS i
JOIN package_contents AS pc
    ON pc.itemId = i.itemId
WHERE i.itemValue * pc.itemQuantity = 100;

-- Question 11
SELECT ts.taskStatusName,
       COUNT(DISTINCT a.volunteerId)
FROM task_status AS ts
LEFT JOIN task AS t
    ON t.taskStatusId = ts.taskStatusId
LEFT JOIN assignment AS a
    ON a.taskCode = t.taskCode
GROUP BY ts.taskStatusId, ts.taskStatusName
ORDER BY COUNT(DISTINCT a.volunteerId) DESC;

-- Question 12
SELECT taskCode, SUM(packageWeight)
FROM package
GROUP BY taskCode
ORDER BY SUM(packageWeight) DESC
LIMIT 1;


-- Question 13
SELECT COUNT(*)
FROM task AS t
JOIN task_type AS tt
    ON tt.taskTypeId = t.taskTypeId
WHERE tt.taskTypeName != 'packing';

-- Question 14
SELECT DISTINCT i.itemDescription
FROM item AS i
JOIN package_contents AS pc
    ON pc.itemId = i.itemId
JOIN package AS p
    ON p.packageId = pc.packageId
LEFT JOIN assignment AS a
    ON a.taskCode = p.taskCode
GROUP BY i.itemId, i.itemDescription
HAVING COUNT(DISTINCT a.volunteerId) < 3;

-- Question 15
SELECT pc.packageId,
       SUM(i.itemValue * pc.itemQuantity)
FROM package_contents AS pc
JOIN item AS i
    ON i.itemId = pc.itemId
GROUP BY pc.packageId
HAVING SUM(i.itemValue * pc.itemQuantity) > 100
ORDER BY SUM(i.itemValue * pc.itemQuantity);

