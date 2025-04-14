
-- Serviços executados com descrição
SELECT os.Numero_OS, s.Descricao, se.Quantidade, s.Valor_Referencia, se.Subtotal
FROM ServicoExecutado se
JOIN Servico s ON se.Cod_Servico = s.Cod_Servico
JOIN OrdemServico os ON se.Numero_OS = os.Numero_OS;
