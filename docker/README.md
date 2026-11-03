# Docker da API NEXO
Pré-requisitos no host: Git e Docker Engine/Desktop funcionando. Não é necessário instalar
Java ou Maven no host; o Dockerfile usa build em múltiplas etapas.

Na raiz deste repositório:
```bash
bash scripts/build-image.sh
bash scripts/run-container.sh demo
bash scripts/verify.sh
python3 scripts/smoke-crud.py
```
Swagger local: http://127.0.0.1:8080/swagger-ui/index.html
O modo demo usa H2 em memória e dados fictícios. Os dados são descartados ao reiniciar.
O teste CRUD altera somente registros sintéticos; executar apenas no modo demo.

Para Oracle, preparar docker/oracle.env a partir de oracle.env.example e preencher
somente no ambiente de execução. Usar permissão restrita no arquivo, por exemplo
`chmod 600 docker/oracle.env`. O usuário Oracle precisa das permissões do CRUD.
Antes da troca, conferir e remover explicitamente o container anterior
(`docker rm -f nexo-api` descarta o banco H2 temporário). Depois:
```bash
bash scripts/run-container.sh oracle
bash scripts/verify.sh
```
A conexão Oracle ainda precisa ser testada. Nenhuma tabela Oracle é criada pelos scripts.
O arquivo real oracle.env é ignorado pelo Git. Não incluir credenciais em commits,
prints, vídeo ou PDF. Não usar o teste CRUD demo contra banco real.

Para encerrar a demonstração local após conferir: `docker rm -f nexo-api`.
