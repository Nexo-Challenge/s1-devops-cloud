# Rodando com Docker

Você precisa de Git, Docker Engine ou Desktop funcionando e Python 3 para o teste
CRUD. Java e Maven ficam na imagem; não precisam estar instalados no computador.

## Demonstração com H2

Na raiz do repositório:

```bash
bash scripts/build-image.sh
bash scripts/run-container.sh demo
bash scripts/verify.sh
python3 scripts/smoke-crud.py
```

Abra o [Swagger](http://127.0.0.1:8080/swagger-ui/index.html) para explorar os endpoints.
O modo `demo` usa dados fictícios em memória. Os testes criam e removem registros
de demonstração, e o banco é reiniciado junto com o container.

Para encerrar a demonstração:

```bash
docker rm -f nexo-api
```

Se o container `nexo-api` já existir, os scripts não o substituem. Confira-o antes
de removê-lo; a remoção descarta os dados H2 daquele container.

## Integração com Oracle

O perfil Oracle está preparado, mas a conexão ainda não foi testada.
Copie `docker/oracle.env.example` para `docker/oracle.env` e preencha os dados do
ambiente. Esse arquivo é ignorado pelo Git; mantenha as credenciais fora de prints,
vídeos e commits. Restrinja a leitura do arquivo com `chmod 600 docker/oracle.env`.

Depois de conferir o banco, as permissões de CRUD e remover o container anterior:

```bash
bash scripts/run-container.sh oracle
bash scripts/verify.sh
```

Os scripts não criam tabelas Oracle. O teste `smoke-crud.py` é para o modo demo;
não execute esse teste contra o banco real.
