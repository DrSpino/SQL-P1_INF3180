SET ECHO ON
/

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY'
/

-- Req1
SELECT  sigle, titre
FROM    Inscription NATURAL JOIN Cours NATURAL JOIN Etudiant
WHERE   nom = 'Tremblay' AND prenom = 'Jean'
/