 SET ECHO ON
 /

 ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY'
 /
 
 SET SERVEROUTPUT ON
 /
 
 SPOOL TP1.out
 /

 -- Req1
 SELECT DISTINCT sigle, titre
 FROM   Inscription NATURAL JOIN Cours NATURAL JOIN Etudiant
 WHERE  nom = 'Tremblay' AND prenom = 'Jean'
 /

 -- Req2
 SELECT codePermanent, prenom, nom
 FROM   Inscription NATURAL JOIN Etudiant NATURAL JOIN SessionUQAM
 WHERE  dateDebut <= '01/02/2004' AND dateFin >= '28/02/2004'
 /

 -- Req3
 SELECT sigle, noGroupe
 FROM   Inscription NATURAL JOIN Etudiant
 WHERE  nom = 'Tremblay' AND prenom = 'Lucie' AND codeSession = 32003
 /

 --Req4
 SELECT codePermanent, nom
 FROM   Etudiant NATURAL JOIN Inscription
 WHERE  sigle = 'INF3180' AND codeSession = 32003 AND dateAbandon IS NULL
 /

 --Req5
 SELECT codeProfesseur, nom
 FROM   Professeur
 WHERE  codeProfesseur IN (
        SELECT codeProfesseur
        FROM Professeur NATURAL JOIN SessionUQAM NATURAL JOIN GroupeCours
        WHERE codeSession = 32003
        GROUP BY codeProfesseur
        HAVING COUNT(*) <= 1
        )
 /

 --Req6
 SELECT nom, prenom, SUM(nbCredits) AS nbCredits
 FROM   Cours NATURAL JOIN Inscription NATURAL JOIN Etudiant
 WHERE  codeProgramme = 7416 AND note >= 70
 GROUP BY nom, prenom
 /

 --Req7
 SELECT sigle, noGroupe, COUNT(codePermanent) AS nbInscrit,
         COUNT(note) AS nbNotes, AVG(note) AS moyenne
 FROM   GroupeCours NATURAL JOIN Inscription
 WHERE  codeSession = 32003
 GROUP BY sigle, noGroupe
 /
 
 --Req8
 DROP VIEW MoyenneParGroupe
 /
 CREATE VIEW MoyenneParGroupe AS
        SELECT  sigle, noGroupe, codeSession, AVG(note) AS moyenne
        FROM    GroupeCours NATURAL JOIN Inscription
        GROUP BY sigle, noGroupe, codeSession
 /
 SELECT *
 FROM   MoyenneParGroupe
 /
 
 --Req9
 SELECT DISTINCT codePermanent, nom
 FROM   Etudiant NATURAL JOIN Inscription
 WHERE  note >= 65
 /

 --Req10
 SELECT sigle, titre
 FROM   Cours
 WHERE  UPPER(titre) LIKE 'PROGRAMMATION%' AND
        UPPER(titre) NOT LIKE '%OBJET%'
 /
 
 --Req11
 SELECT codePermanent, AVG(note) AS moyenne
 FROM   Inscription
 WHERE  codeSession = 32003
 GROUP BY codePermanent
 HAVING AVG(note) > 80
 /

 --Req12
 SELECT nom, prenom, SUM(NVL(nbCredits,0)) AS nbCredit
 FROM   Professeur
                LEFT JOIN GroupeCours ON Professeur.codeProfesseur = GroupeCours.codeProfesseur
                LEFT JOIN Cours ON  GroupeCours.sigle =  Cours.sigle
 GROUP BY nom, prenom
 ORDER BY nbCredit DESC, nom ASC, prenom ASC
 /

 --Req13
 SELECT codePermanent, sigle, noGroupe, codeSession, dateAbandon, (dateAbandon - dateDebut) AS nbJours
 FROM   SessionUQAM NATURAL JOIN Inscription
 WHERE  (dateAbandon - dateDebut) >= 15
 /

 --Req14
 SELECT sigle, noGroupe, codeSession
 FROM   GroupeCours
 MINUS
 SELECT sigle, noGroupe, codeSession
 FROM   GroupeCours NATURAL JOIN Inscription
 /

 --Req15
 SELECT DISTINCT leNom, lePrenom
 FROM   (SELECT nom as leNom, prenom as lePrenom, codePermanent
                 FROM   Etudiant) E NATURAL JOIN
                Inscription NATURAL JOIN GroupeCours NATURAL JOIN Professeur
 WHERE  prenom = 'Blaise' AND nom = 'Pascal'
 ORDER BY leNom, lePrenom
 /

 EXIT
 /
