
-- Equipes que executaram mais de 1 OS
SELECT e.Cod_Equipe, COUNT(ex.Numero_OS) AS Total_OS
FROM Executa ex
JOIN Equipe e ON e.Cod_Equipe = ex.Cod_Equipe
GROUP BY e.Cod_Equipe
HAVING COUNT(ex.Numero_OS) > 1;
