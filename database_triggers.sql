
-- ------------------------------------------------------------------------------
-- RÈGLE 1 : Une offre d'emploi ne peut pas être supprimée, uniquement archivée.
-- TEST : On va tenter de supprimer une offre d'emploi de la base de données.
-- RESULTAT ATTENDU : Le trigger bloque la suppression avec une erreur.
-- Message : "Suppression interdite : une offre d emploi ne peut pas être supprimée, uniquement archivée (statut fermee)"
-- ------------------------------------------------------------------------------
DELETE FROM OFFRE_EMPLOI WHERE id_offre = 1;


-- ------------------------------------------------------------------------------
-- RÈGLE 2 : Lorsqu'une offre passe de 'ouverte' à 'fermee', la date de fermeture
-- est enregistrée automatiquement.
-- TEST : On ferme une offre sans renseigner manuellement la date_fermeture.
-- RESULTAT ATTENDU : Le trigger remplit automatiquement date_fermeture avec la date du jour.
-- ------------------------------------------------------------------------------
-- 1. On vérifie que date_fermeture est NULL avant la fermeture
SELECT id_offre, statut, date_fermeture
FROM OFFRE_EMPLOI
WHERE id_offre = 3;
 
-- 2. On ferme l'offre sans mettre de date_fermeture manuellement
UPDATE OFFRE_EMPLOI
SET statut = 'fermee'
WHERE id_offre = 3;
 
-- 3. On vérifie que date_fermeture a bien été remplie automatiquement avec la date du jour
SELECT id_offre, statut, date_fermeture
FROM OFFRE_EMPLOI
WHERE id_offre = 3;



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
WHERE CANDIDAT_id_candidat = 1 AND OFFRE_EMPLOI_id_offre = 3; -- ATTENTION ici il n'y a pas de message d'erreur


-- ------------------------------------------------------------------------------
-- RÈGLE 5 : Une candidature ne peut être obtenue si elle a déjà été obtenue par un autre candidat.
-- TEST : On accepte un candidat pour une offre, puis on essaie d'accepter un autre candidat pour la même offre.
-- RESULTAT ATTENDU : Le trigger bloque le 2ème UPDATE avec une erreur.
-- Message : "Erreur (Règle 5) : Cette offre a déjà été obtenue par un autre candidat"
-- ------------------------------------------------------------------------------
-- 1. On accepte le candidat 3 pour l'offre 5 (Le trigger laisse passer)
UPDATE CANDIDATURE
SET statut_candidature = 2
WHERE CANDIDAT_id_candidat = 3 AND OFFRE_EMPLOI_id_offre = 5;
 
-- 2. On tente d'accepter le candidat 5 pour la même offre 5
-- (C'EST ICI QUE CA DOIT PLANTER avec le message "Cette offre a déjà été obtenue par un autre candidat")
UPDATE CANDIDATURE
SET statut_candidature = 2
WHERE CANDIDAT_id_candidat = 5 AND OFFRE_EMPLOI_id_offre = 5;
-- IL N'Y A PAS D'ERREUR ici 

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