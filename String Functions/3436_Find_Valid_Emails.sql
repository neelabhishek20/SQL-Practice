SELECT 
    user_id,
    email
FROM Users as u
WHERE email REGEXP "^[A-Za-z0-9_]+@[A-Za-z]+\\.com$"
ORDER BY user_id;
