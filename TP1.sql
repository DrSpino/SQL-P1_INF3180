 SET ECHO ON
 /
  
 ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY'
 /
  
 -- Req1
 SELECT  sigle, titre
 FROM    Inscription NATURAL JOIN Cours NATURAL JOIN Etudiant
 WHERE   nom = 'Tremblay' AND prenom = 'Jean'
 /
 -- Req2
 
 
 
 -- Req3
 SELECT  sigle, noGroupe
 FROM    Inscription NATURAL JOIN Etudiant NATURAL JOIN Cours
 WHERE   nom = 'Tremblay' AND prenom = 'Lucie'AND codeSession = 32003
 /
 
 --Req4
 SELECT codePermanent, nom
 FROM Etudiant NATURAL JOIN Inscription
 WHERE sigle = 'INF3180' AND codeSession = 32003 AND dateAbandon IS NULL
 /
 
 --Req5

 
