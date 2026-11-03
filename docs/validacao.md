# Resultados dos testes

## API Java

Fonte: [s1-java-api](https://github.com/Nexo-Challenge/s1-java-api), commit
`b277672b3ed25ac2bd2970fbd6824dc3d38bae86`, sem alterações no código Java.

Com Temurin 21.0.13 e Maven Wrapper 3.9.11, os **61 testes passaram**, sem falhas,
erros ou testes ignorados. O JAR executável foi gerado com `BUILD SUCCESS`.
Neste ambiente, o Mockito precisou de `javaagent` via `argLine`; o POM foi mantido.

O JAR também foi iniciado com H2 para testar os endpoints e os dados de demonstração.
Os scripts passaram por `bash -n`, e o Python teve a compilação verificada.
Essas verificações foram separadas do build Docker, que usa `-DskipTests`.

## Docker na Azure — 02/11/2026, horário de São Paulo

| Item | Resultado registrado |
| --- | --- |
| Grupo | `rg-nexo-sprint1`, criado por Azure CLI |
| VM | `vm-nexo-sprint1`, Ubuntu, `eastus`, `Standard_D2s_v4`, 2 vCPU e 8 GiB |
| Estado durante os testes | `VM running` |
| Build Docker | Concluído na própria VM |
| Imagem / container | `nexo-api:sprint1` / `nexo-api` |
| Processo | `java -jar app.jar`, usuário `10001:10001` |
| Acesso | Somente `127.0.0.1:8080` da VM, via Run Command |

ID da imagem construída:

```text
sha256:c48834a2740b7e88d0579f27ced987ff721fb90ef770abda2beed859bd862244
```

Swagger UI, OpenAPI JSON, `/api/aplicacoes` e `/api/areas` retornaram **HTTP 200**.
O teste CRUD teve os seguintes resultados:

| Operação | HTTP |
| --- | --- |
| Criar | 201 |
| Consultar | 200 |
| Atualizar | 200 |
| Enviar entrada inválida | 400 |
| Excluir | 204 |
| Consultar após excluir | 404 |

Após reiniciar o container, os testes HTTP e CRUD passaram novamente, com o marcador
`NEXO_COLD_START_OK`. O health check recebeu `--retry-all-errors` para aguardar a
inicialização mesmo quando a conexão é reiniciada antes de o servidor ficar pronto.

Também passou o build e teste HTTP/CRUD no GitHub Actions:
[execução 41564440786](https://github.com/Nexo-Challenge/s1-devops-cloud/actions/runs/41564440786).

## Ambiente e próximos passos

O desligamento automático foi configurado para **03:00 UTC**, equivalente a
**00h de 03/11/2026 em São Paulo**. O horário se repete diariamente e não exclui
disco nem IP.

Oracle não foi acessado. A demonstração usa H2 temporário. Ainda faltam o vídeo,
o PDF com os links e a exclusão do grupo após guardar as evidências.
Os arquivos estão no [PR #2](https://github.com/Nexo-Challenge/s1-devops-cloud/pull/2),
aberto para revisão; a implantação foi feita por pacote local.

## Onde ficaram as evidências

[evidence/validacao-azure.txt](../evidence/validacao-azure.txt) contém o resumo da
saída conferida no terminal. Os logs brutos foram gerados em `~/NEXO-DevOps/evidence`
e compactados em `~/NEXO-Azure-evidencias.zip` no Cloud Shell, mas o download pela
interface falhou. Por isso, eles não estão neste pacote.

Backups privados podem ser guardados em `evidence/private`, ignorado pelo Git.
As evidências publicadas não incluem credenciais nem IDs da assinatura.
