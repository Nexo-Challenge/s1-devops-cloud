# Estado de validação

## Verificado nesta preparação
- Fonte Java: commit b277672b3ed25ac2bd2970fbd6824dc3d38bae86 de Nexo-Challenge/s1-java-api.
- Temurin 21.0.13, Maven Wrapper 3.9.11: 61 testes, zero falhas/erros/ignorados.
- JAR executável gerado com BUILD SUCCESS.
- Processo do JAR com H2 temporário: HTTP 200 em /v3/api-docs, /swagger-ui/index.html, /api/aplicacoes e /api/areas.
- No ambiente da preparação, Mockito exigiu inicialização com javaagent via argLine; não houve alteração no POM.
- A API Java permanece sem alterações.

- Scripts Bash: sintaxe validada com bash -n; Python: compilação validada.
- Configuração demo testada no JAR real: seed H2 e endpoints HTTP 200.
- Teste CRUD demo aprovado: POST 201, GET 200, PUT 200, entrada inválida 400, DELETE 204 e GET após exclusão 404.
- Teste acima executado sem Docker; não comprova a imagem.

## Verificação real na Azure - 02/11/2026, horário de São Paulo
- Grupo criado por Azure CLI: rg-nexo-sprint1.
- VM: vm-nexo-sprint1; região eastus; Standard_D2s_v4, 2 vCPU e 8 GiB.
- Estado observado: VM running.
- Dockerfile construído na própria VM: BUILD SUCCESS.
- Imagem: nexo-api:sprint1.
- ID: sha256:c48834a2740b7e88d0579f27ced987ff721fb90ef770abda2beed859bd862244.
- Container nexo-api, processo java -jar app.jar, usuário 10001:10001.
- Porta publicada apenas em 127.0.0.1:8080 da VM; não há acesso público HTTP.
- Swagger UI, OpenAPI JSON, aplicações e áreas responderam HTTP 200.
- CRUD remoto: POST 201, GET 200, PUT 200, validação 400, DELETE 204 e GET após exclusão 404.
- Partida a frio: container reiniciado e testes HTTP/CRUD aprovados novamente, com marcador NEXO_COLD_START_OK.
- A espera inicial do health check foi ajustada com --retry-all-errors para tolerar resets de conexão enquanto o servidor sobe. Os logs brutos preservam as mensagens transitórias e o resultado final.
- Desligamento automático habilitado: 03:00 UTC, equivalente a 00:00 de 03/11/2026 em São Paulo. O horário se repete diariamente. Disco/IP não são excluídos por esse desligamento.
- A imagem foi validada diretamente na VM. A validação por GitHub Actions é complementar; consultar a execução do workflow no PR para seu resultado.

## A concluir
- Exclusão do grupo depois de gravar as evidências.
- Oracle: nenhum acesso realizado; requer schema e credenciais fornecidos ao ambiente.
- Vídeo, PDF com os links reais e conferência final da entrega.

Esta página registra resultados observados; a existência de um script não comprova sua execução.

## Publicação
Os arquivos de infraestrutura e documentação são publicados em branch para revisão. A implantação por pacote local não depende de merge na main e a API Java permanece no repositório original.

## Evidências
Saídas brutas foram geradas em ~/NEXO-DevOps/evidence no Cloud Shell e compactadas em ~/NEXO-Azure-evidencias.zip. O download pela interface do Cloud Shell falhou; portanto, esses logs brutos não estão neste pacote. O resumo acima foi conferido na saída visível do terminal. evidence/private é ignorado pelo Git para eventuais backups privados futuros. Não foram incluídas credenciais nem IDs da assinatura no resumo.
