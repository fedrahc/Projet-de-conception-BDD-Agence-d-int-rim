--1. Une liste des candidats et des offres auxquelles ils ont postulées. 
SELECT p.nom, p.prenom, o.intule AS offre_postule 
--pour la liste on prend juste le nom et prénom, on doit passer par PERSONNE 
--et les offres que les titres en passant par candidature 
--pour vérifier ceux qui ont postulées, et pas toutes les offres
FROM CANDIDAT c
JOIN PERSONNE p 
    ON c.PERSONNE_id_personne = p.id_personne
JOIN CANDIDATURE cand 
    ON c.id_candidat = cand.CANDIDAT_id_candidat
JOIN OFFRE_EMPLOI o 
    ON cand.OFFRE_EMPLOI_id_offre = o.id_offre;


--2. Proposez une ou plusieurs requêtes pour afficher toutes les informations 
--d’un candidat (Informations personnelles, diplômes, métiers, compétences, offres d’emploi, etc.) 

-- ici pour sélectionner le candidat donné on va utiliser 
-- WHERE c.id_candidat = 1;
-- avec 1 comme ID qui mimique l'ID du candidat souhaitée

-- en premier les information personelle du client 
SELECT p.nom, p.prenom, p.email, p.telephone, c.description, c.disponibilite
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
JOIN CANDIDAT_HAS_COMPETENCE chc 
    ON comp.id_competence = chc.COMPETENCE_id_competence
WHERE chc.CANDIDAT_id_candidat = 1;

-- métier
SELECT m.libelle
FROM METIER m
JOIN CANDIDAT_METIER cm 
    ON m.id_metier = cm.METIER_id_metier
WHERE cm.CANDIDAT_id_candidat = 1;

-- offres d'emplois (auxquels le candidat a postulé)
SELECT m.libelle
FROM METIER m
JOIN CANDIDAT_METIER cm 
    ON m.id_metier = cm.METIER_id_metier
WHERE cm.CANDIDAT_id_candidat = 1;



--3. Lister les candidats qui ont postulé à toutes les offres d’emploi 
SELECT c.id_candidat, p.nom, p.prenom
FROM CANDIDAT c
JOIN PERSONNE p 
    ON c.PERSONNE_id_personne = p.id_personne
JOIN CANDIDATURE cand 
    ON c.id_candidat = cand.CANDIDAT_id_candidat
GROUP BY c.id_candidat, p.nom, p.prenom
-- le having count compte le nbre total d'offre et match 
--si il est égal aux nbr d'offre emploi que le candidat a candidater
HAVING COUNT(DISTINCT cand.OFFRE_EMPLOI_id_offre) = (SELECT COUNT(*) FROM OFFRE_EMPLOI);

--7. Lister les compétences qui ne sont pas rattachées à des candidats 
SELECT comp.id_competence, comp.libelle
FROM COMPETENCE comp
LEFT JOIN CANDIDAT_HAS_COMPETENCE chc 
    ON comp.id_competence = chc.COMPETENCE_id_competence
WHERE chc.CANDIDAT_id_candidat IS NULL;


--8. Lister les candidats potentiels (qui n’ont pas encore candidaté) 
--pour une offre d’emploi donnée (c.à.d les candidats qui sont liés 
--aux métiers ou compétences requises par l’offre d’emploi) 
SELECT DISTINCT c.id_candidat, p.nom, p.prenom
FROM CANDIDAT c
JOIN PERSONNE p 
    ON c.PERSONNE_id_personne = p.id_personne
JOIN CANDIDAT_HAS_COMPETENCE chc   
    ON c.id_candidat = chc.CANDIDAT_id_candidat
JOIN OFFRE_EMPLOI_HAS_COMPETENCE ohc 
    ON chc.COMPETENCE_id_competence = ohc.COMPETENCE_id_competence
WHERE ohc.OFFRE_EMPLOI_id_offre = 1 -- l'id de l'offre d'emploi donnée = 1
-- ici c'est pour filtrer les candidats qui ont déjà candidater + qui match les compétences
    AND c.id_candidat NOT IN (
        SELECT CANDIDAT_id_candidat 
        FROM CANDIDATURE 
        WHERE OFFRE_EMPLOI_id_offre = 1
);