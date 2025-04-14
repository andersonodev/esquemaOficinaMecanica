
-- Dias estimados de execução
SELECT Numero_OS, DATEDIFF(Data_Conclusao_Prevista, Data_Emissao) AS Dias_Execucao
FROM OrdemServico;
