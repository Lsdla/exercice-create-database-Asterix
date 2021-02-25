-- Créate User:

CREATE USER 'sqlix_u'@'localhost' IDENTIFIED BY 'lye';
GRANT SELECT, INSERT, UPDATE, DELETE ON sqlix.* TO 'sqlix_u'@'localhost'; 