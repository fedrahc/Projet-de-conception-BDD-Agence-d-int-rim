-- 1. Une liste des candidats et des offres auxquelles ils ont postulées. 
SELECT p.nom, p.prenom, o.intitule AS offre_postule 
-- pour la liste on prend juste le nom et prénom, on doit passer par PERSONNE 
-- et les offres que les titres en passant par candidature 
-- pour vérifier ceux qui ont postulées, et pas toutes les offres
FROM CANDIDAT c
JOIN PERSONNE p 
    ON c.PERSONNE_id_personne = p.id_personne
JOIN CANDIDATURE cand 
    ON c.id_candidat = cand.CANDIDAT_id_candidat
JOIN OFFRE_EMPLOI o 
    ON cand.OFFRE_EMPLOI_id_offre = o.id_offre;


-- 2. Proposez une ou plusieurs requêtes pour afficher toutes les informations 
-- d’un candidat (Informations personnelles, diplômes, métiers, compétences, offres d’emploi, etc.) 

-- ici pour sélectionner le candidat donné on va utiliser 
-- WHERE c.id_candidat = 1;
-- avec 1 comme ID qui mimique l'ID du candidat souhaitée

-- en premier les information personelle du client 
SELECT p.nom, p.prenom, p.email, p.téléphone, c.description, c.disponibilite
FROM CANDIDAT c
JOIN PERSONNE p 
    ON c.PERSONNE_id_personne = p.id_personne
WHERE c.id_candidat = 1;

-- puis les diplômes
SELECT libelle, niveau_etudes
FROM DIPLOME
WHERE CANDIDAT_id_candidat = 1;

-- expériences professionelles
SELECT type_contrat, date_debut, date_fin
FROM EXPERIENCE_PRO
WHERE CANDIDAT_id_candidat = 1;

-- compétences 
SELECT comp.libelle
FROM COMPETENCE comp
JOIN CANDIDAT_has_COMPETENCE chc 
    ON comp.id_competence = chc.COMPETENCE_id_competence
WHERE chc.CANDIDAT_id_candidat = 1;

-- métier
SELECT m.libelle
FROM METIER m
JOIN CANDIDAT_METIER cm 
    ON m.id_metier = cm.METIER_id_metier
WHERE cm.CANDIDAT_id_candidat = 1;

-- offres d'emplois (auxquels le candidat a postulé)
SELECT o.intitule, o.type_contrat, o.statut, cand.statut_candidature
FROM CANDIDATURE cand
JOIN OFFRE_EMPLOI o
    ON cand.OFFRE_EMPLOI_id_offre = o.id_offre
WHERE cand.CANDIDAT_id_candidat = 1;



-- 3. Lister les candidats qui ont postulé à toutes les offres d’emploi 
SELECT c.id_candidat, p.nom, p.prenom
FROM CANDIDAT c
JOIN PERSONNE p 
    ON c.PERSONNE_id_personne = p.id_personne
JOIN CANDIDATURE cand 
    ON c.id_candidat = cand.CANDIDAT_id_candidat
GROUP BY c.id_candidat, p.nom, p.prenom
-- le having count compte le nbre total d'offre et match 
-- si il est égal aux nbr d'offre emploi que le candidat a candidater
HAVING COUNT(DISTINCT cand.OFFRE_EMPLOI_id_offre) = (SELECT COUNT(*) FROM OFFRE_EMPLOI);


-- Requête 4 : Calculer la somme des commissions perçues par l'agence
-- (toutes périodes confondues)
SELECT SUM(taux_horaire * heures_mensuel * 0.10) AS total_commissions
FROM OFFRE_EMPLOI;

-- Requête 5 : Même chose que la 4, mais groupée par mois

SELECT
    YEAR(date_debut)  AS annee,
    MONTH(date_debut) AS mois,
    SUM(taux_horaire * heures_mensuel * 0.10) AS commissions_mois
FROM OFFRE_EMPLOI
GROUP BY YEAR(date_debut), MONTH(date_debut)
ORDER BY annee, mois;

-- Requête 6 : Commissions par salarié (et non par agence)
-- Chaque salarié est responsable des offres qu'il gère
-- On joint OFFRE_EMPLOI -> SALARIE -> PERSONNE pour avoir les noms

SELECT
    p.nom,
    p.prenom,
    s.role,
    SUM(o.taux_horaire * o.heures_mensuel * 0.10) AS commission_salarie
FROM OFFRE_EMPLOI o
JOIN SALARIE s
    ON o.SALARIE_id_salarie = s.id_salarie
JOIN PERSONNE p
    ON s.PERSONNE_id_personne = p.id_personne
GROUP BY s.id_salarie, p.nom, p.prenom, s.role
ORDER BY commission_salarie DESC;



-- 7. Lister les compétences qui ne sont pas rattachées à des candidats 
SELECT comp.id_competence, comp.libelle
FROM COMPETENCE comp
LEFT JOIN CANDIDAT_has_COMPETENCE chc 
    ON comp.id_competence = chc.COMPETENCE_id_competence
WHERE chc.CANDIDAT_id_candidat IS NULL;


-- 8. Lister les candidats potentiels (qui n’ont pas encore candidaté) 
-- pour une offre d’emploi donnée (c.à.d les candidats qui sont liés 
-- aux métiers ou compétences requises par l’offre d’emploi) 
SELECT DISTINCT c.id_candidat, p.nom, p.prenom
FROM CANDIDAT c
JOIN PERSONNE p 
    ON c.PERSONNE_id_personne = p.id_personne
JOIN CANDIDAT_has_COMPETENCE chc   
    ON c.id_candidat = chc.CANDIDAT_id_candidat
JOIN OFFRE_EMPLOI_has_COMPETENCE ohc 
    ON chc.COMPETENCE_id_competence = ohc.COMPETENCE_id_competence
WHERE ohc.OFFRE_EMPLOI_id_offre = 1 -- l'id de l'offre d'emploi donnée = 1
-- ici c'est pour filtrer les candidats qui ont déjà candidater + qui match les compétences
    AND c.id_candidat NOT IN (
        SELECT CANDIDAT_id_candidat 
        FROM CANDIDATURE 
        WHERE OFFRE_EMPLOI_id_offre = 1
);


-- Requête 9 : Ajouter les candidatures pour les candidats listés en requête 8
-- On crée d'abord une VUE basée sur la requête 8 (candidats potentiels),
-- puis on insère directement depuis cette vue.
-- Ainsi aucun identifiant n'est listé manuellement.- Étape 1 : créer la vue des candidats potentiels pour l'offre 1
CREATE OR REPLACE VIEW vue_candidats_potentiels AS
SELECT DISTINCT c.id_candidat
FROM CANDIDAT c
JOIN CANDIDAT_has_COMPETENCE chc
    ON c.id_candidat = chc.CANDIDAT_id_candidat
JOIN OFFRE_EMPLOI_has_COMPETENCE ohc
    ON chc.COMPETENCE_id_competence = ohc.COMPETENCE_id_competence
WHERE ohc.OFFRE_EMPLOI_id_offre = 1
AND   ohc.OFFRE_EMPLOI_ENTREPRISE_id_entreprise = 1
AND   c.id_candidat NOT IN (
    SELECT CANDIDAT_id_candidat
    FROM CANDIDATURE
    WHERE OFFRE_EMPLOI_id_offre = 1
);

INSERT INTO CANDIDATURE (statut_candidature, CANDIDAT_id_candidat, OFFRE_EMPLOI_id_offre)
SELECT 0, id_candidat, 1
FROM vue_candidats_potentiels;




-- Requête 10 : Fermer une offre d'emploi et l'attribuer à un candidat

-- Étape 1 : fermer l'offre
UPDATE OFFRE_EMPLOI
SET statut = 'fermee',
    date_fermeture = CURDATE()
WHERE id_offre = 1;

-- Étape 2 : accepter le candidat retenu
UPDATE CANDIDATURE
SET statut_candidature = 2
WHERE OFFRE_EMPLOI_id_offre = 1
AND   CANDIDAT_id_candidat  = 1;

-- Étape 3 : refuser les autres candidats de cette offre
UPDATE CANDIDATURE
SET statut_candidature = 1
WHERE OFFRE_EMPLOI_id_offre = 1
AND   CANDIDAT_id_candidat != 1;


