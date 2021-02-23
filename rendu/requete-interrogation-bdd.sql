--1) Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)

SELECT num_potion, lib_potion, formule, constituant_principal 
from potion;

--2) Liste des noms des trophées rapportant 3 points. (2 lignes)

SELECT nom_categ 
FROM categorie WHERE nb_points = 3;

--3) Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)

SELECT nom_village 
FROM village 
WHERE nb_huttes > 35;

--4) Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)

SELECT num_trophee
FROM trophee 
WHERE date_prise 
LIKE "%52-05%" 
OR date_prise 
LIKE "%52-06%";

--5) Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)

SELECT nom 
FROM habitant 
WHERE nom 
like "a%" 
AND nom 
LIKE "%r%";

--6) Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)

SELECT nom 
FROM habitant 
INNER JOIN absorber ON habitant.num_hab = absorber.num_hab 
WHERE num_potion = 1 OR num_potion = 3 OR num_potion = 4 
GROUP BY nom;

--7) Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10 lignes)

SELECT num_trophee,	date_prise,	code_cat, num_preneur 
FROM trophee

--8) Nom des habitants qui habitent à Aquilona. (7 lignes)

SELECT nom 
FROM habitant 
INNER JOIN village ON village.num_village = habitant.num_village 
WHERE nom_village = 'Aquilona';

--9) Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)

SELECT nom
FROM habitant 
INNER JOIN trophee ON trophee.num_preneur = habitant.num_hab
INNER JOIN categorie ON trophee.code_cat = categorie.code_cat WHERE nom_categ = 'Bouclier de Légat';

--10) Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituant principal. (3 lignes)

SELECT lib_potion, formule, constituant_principal
FROM potion 
INNER JOIN fabriquer on fabriquer.num_potion = potion.num_potion
INNER JOIN habitant on fabriquer.num_hab = habitant.num_hab
WHERE nom = 'Panoramix';

--11) Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)

SELECT lib_potion
FROM potion 
INNER JOIN absorber on absorber.num_potion = potion.num_potion
INNER JOIN habitant on absorber.num_hab = habitant.num_hab
WHERE nom = 'Homéopatix'
group BY lib_potion;

--12) Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro3. (4 lignes)

SELECT nom FROM habitant
INNER JOIN absorber a ON a.num_hab = habitant.num_hab
INNER JOIN fabriquer ON fabriquer.num_potion = a.num_potion
WHERE fabriquer.num_hab = 3
GROUP BY nom;

--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)

SELECT nom FROM habitant
INNER JOIN absorber a ON a.num_hab = habitant.num_hab
INNER JOIN fabriquer ON fabriquer.num_potion = a.num_potion
WHERE fabriquer.num_hab = (SELECT num_hab FROM habitant WHERE nom = 'Amnésix')
GROUP BY nom;

--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)

SELECT nom FROM habitant
WHERE num_qualite is null;

--15. Nom des habitants ayant consommé la potion magique n°1 (c'est le libellé de la potion) en février 52. (3 lignes)

SELECT nom FROM habitant h
INNER JOIN absorber a ON h.num_hab = a.num_hab
INNER JOIN potion p ON a.num_potion = p.num_potion
where lib_potion LIKE '%n°1' AND date_a LIKE '%52-02%';

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)

SELECT nom, age
FROM habitant
ORDER BY nom;

--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)

SELECT nom_resserre, num_village FROM resserre	 ORDER BY num_resserre DESC; 
Ou bien 
SELECT nom_resserre, nom_village FROM resserre INNER JOIN village ON village.num_village = resserre.num_village ORDER BY num_resserre DESC

--18. Nombre d'habitants du village numéro 5. (Reponse = 4)

SELECT 
COUNT(*) AS nbre_hab
FROM habitant 
WHERE num_village = 5

--19. Nombre de points gagnés par Goudurix. (Réponse = 5)

SELECT sum(nb_points) AS total_points
FROM categorie c
INNER JOIN trophee t ON t.code_cat = c.code_cat
INNER JOIN habitant h ON h.num_hab = t.num_preneur
WHERE h.nom = 'Goudurix';

--20. Date de première prise de trophée. (Réponse = 03/04/52)

SELECT date_prise 
FROM trophee 
ORDER BY date_prise LIMIT 1;

--21. Nombre de louches de potion magique n°2 (c'est le libellé de la potion) absorbées. (Réponse =19)

SELECT SUM(quantite) AS nbre_louche
FROM absorber a
INNER JOIN potion p ON a.num_potion = p.num_potion
WHERE lib_potion LIKE '%n°2';

--22. Superficie la plus grande. (895)

SELECT MAX(superficie) FROM resserre;

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)

SELECT village.nom_village, Count(habitant.num_hab) AS nbre_habitant
FROM village INNER JOIN habitant ON village.num_village = habitant.num_village
GROUP BY village.nom_village

--24) Nombre de trophées par habitant (6 lignes)

SELECT habitant.nom, Count(trophee.num_preneur) AS nbre_trophee
FROM trophee INNER JOIN habitant ON habitant.num_hab = trophee.num_preneur
GROUP BY habitant.nom;


--25) Moyenne d\'âge des habitants par province (nom de province, calcul). (3 lignes)

SELECT province.nom_province, AVG(habitant.age) AS moyenne
FROM province 
INNER JOIN village ON village.num_province = province.num_province
INNER JOIN habitant ON habitant.num_village = village.num_village
GROUP BY nom_province;

--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)

SELECT nom, COUNT(absorber.num_potion) AS nbre_potion FROM absorber 
INNER JOIN habitant  ON habitant.num_hab = absorber.num_hab
GROUP BY nom;

--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)

SELECT nom FROM habitant h
INNER JOIN absorber a ON h.num_hab = a.num_hab
INNER JOIN potion p ON a.num_potion = p.num_potion
WHERE quantite > 2 AND lib_potion = 'Potion Zen';

--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)

SELECT nom_village FROM village v
INNER JOIN resserre r ON v.num_village = r.num_village
WHERE num_resserre is NOT null;

--29. Nom du village contenant le plus grand nombre de huttes. (reponse= Gergovie)

SELECT nom_village FROM village 
ORDER BY nb_huttes DESC LIMIT 1;

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes)

SELECT nom, COUNT(num_trophee) AS nbre_trophee FROM trophee 
INNER JOIN habitant ON habitant.num_hab = trophee.num_preneur
GROUP BY nom
HAVING nbre_trophee > (SELECT COUNT(num_trophee) AS nbre_trophee FROM trophee
INNER JOIN habitant ON habitant.num_hab = trophee.num_preneur
WHERE nom = 'Obélix');
