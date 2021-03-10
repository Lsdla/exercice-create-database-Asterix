-- Créate User:

-- Création du User  j'ai mis un mot de passe 'lye': 

CREATE USER 'sqlix_u'@'localhost' IDENTIFIED BY 'lye';


GRANT SELECT, INSERT, UPDATE, DELETE ON sqlix.* TO 'sqlix_u'@'localhost'; 