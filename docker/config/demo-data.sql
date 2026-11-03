INSERT INTO TB_AREA_APLICACAO (nome, descricao)
VALUES ('Saúde - demonstração', 'Área fictícia para validar a infraestrutura do NEXO.');
INSERT INTO TB_APLICACAO_NUCLEAR (area_aplicacao_id, titulo, resumo, descricao)
SELECT id, 'Missão hospital - demonstração', 'Conteúdo fictício para teste de implantação.',
       'Registro de demonstração da API NEXO, sem informações de pacientes.'
FROM TB_AREA_APLICACAO WHERE nome = 'Saúde - demonstração';
