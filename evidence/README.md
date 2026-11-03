# Evidências

O resumo da execução na Azure está em [validacao-azure.txt](validacao-azure.txt).
Os testes, versões e limitações estão em [resultados dos testes](../docs/validacao.md).
Os logs brutos ficaram no Cloud Shell; o download pela interface falhou.

Para a gravação, separe estas saídas:

1. Criação por Azure CLI e VM com estado `running`.
2. Build Docker concluído e ID da imagem.
3. `docker ps` mostrando o container na VM.
4. `verify-vm.sh` mostrando as respostas HTTP e o JSON da API.
5. Exclusão do grupo, com `az group exists` retornando `false`.

Há também uma [execução aprovada do GitHub Actions](https://github.com/Nexo-Challenge/s1-devops-cloud/actions/runs/41564440786).
A confirmação de exclusão ainda está pendente e deve ser registrada depois das
demais evidências. Confira o [roteiro do vídeo](../docs/roteiro-video.md) antes de gravar
e não inclua credenciais nas capturas.
