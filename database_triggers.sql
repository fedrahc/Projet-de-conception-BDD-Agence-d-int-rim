
-- ------------------------------------------------------------------------------
-- RÈGLE 3 : Conservation des données non personnelles pour archive (Anonymisation).
-- TEST : On va tenter de supprimer un candidat de la base de données.
-- RESULTAT ATTENDU : Le trigger bloque la suppression (Erreur), mais si on fait un SELECT sur la personne, elle est devenue "Anonyme".
-- ------------------------------------------------------------------------------
-- 1. On déclenche la suppression du candidat 2 (C'EST ICI QUE L'ERREUR APPARAÎT)
DELETE FROM CANDIDAT WHERE id_candidat = 2;

-- 2. On vérifie que le trigger a bien fait son travail de l'ombre en regardant la table PERSONNE
-- On doit voir "Anonyme" "Anonyme" avec des champs NULL à la place de ses vraies données.
SELECT * FROM PERSONNE WHERE id_personne = 2;

-- ------------------------------------------------------------------------------
-- RÈGLE 4 : Les candidats ne peuvent pas obtenir une offre d’emploi s’ils ne sont pas disponibles.
-- TEST : On va donner une première offre au candidat 1, puis essayer de lui en donner une deuxième.
-- RESULTAT ATTENDU : Le trigger trg_verif_disponibilite va bloquer le 2ème UPDATE.
-- ------------------------------------------------------------------------------
-- 1. On s'assure d'abord que le candidat 1 obtient l'offre 1 (Le trigger laisse passer)
UPDATE CANDIDATURE 
SET statut_candidature = 2 
WHERE CANDIDAT_id_candidat = 1 AND OFFRE_EMPLOI_id_offre = 1;

-- 2. On tente de lui faire accepter une deuxième offre (l'offre 3) en même temps
-- (C'EST ICI QUE ÇA DOIT PLANTER avec le message "Ce candidat n'est pas disponible")
UPDATE CANDIDATURE 
SET statut_candidature = 2 
WHERE CANDIDAT_id_candidat = 1 AND OFFRE_EMPLOI_id_offre = 3;


-- ------------------------------------------------------------------------------
-- RÈGLE 6 : Routine qui change le statut des candidats à disponible si leur emploi est terminé.
-- TEST : On exécute la procédure et on vérifie si les statuts ont bien été mis à jour.
-- RESULTAT ATTENDU : La commande s'exécute avec succès ("0 row(s) affected" ou plus selon les données).
-- ------------------------------------------------------------------------------
-- 1. On lance la procédure stockée
CALL update_disponibilite();

-- 2. On vérifie le résultat : On liste les candidats pour voir leur disponibilité actuelle
SELECT c.id_candidat, p.nom, p.prenom, c.disponibilite 
FROM CANDIDAT c
JOIN PERSONNE p ON c.PERSONNE_id_personne = p.id_personne;



-- ------------------------------------------------------------------------------
-- RÈGLE 7 : Les candidats doivent être âgés d’au moins 16 ans.
-- TEST : On va créer une personne très jeune (née en 2020) et tenter de l'insérer comme candidat.
-- RESULTAT ATTENDU : Le trigger trg_verif_age_candidat va bloquer l'insertion avec une erreur.
-- ------------------------------------------------------------------------------
-- 1. On crée d'abord un enfant dans la table PERSONNE
INSERT INTO PERSONNE (id_personne, nom, prenom, date_naissance, adresse, téléphone, email) 
VALUES (99, 'Test', 'Enfant', '2020-01-01', '123 rue', '0000', 'enfant@test.com');

-- 2. On tente de l'ajouter comme candidat (C'EST ICI QUE ÇA DOIT PLANTER)
INSERT INTO CANDIDAT (id_candidat, description, disponibilite, PERSONNE_id_personne) 
VALUES (99, 'Trop jeune', 'disponible', 99);