# Arquitetura da demonstração
Ver [arquitetura.svg](arquitetura.svg) para a versão visual com ícones.

O usuário executa Azure CLI no Cloud Shell. A CLI provisiona e administra a VM Ubuntu.
Azure VM Agent executa os scripts dentro da VM por Run Command. O Docker hospeda a API
Java 21/Spring Boot na porta 8080. O banco H2 vive na memória do mesmo processo Java
no modo demo, com registros fictícios. Reiniciar o processo descarta os dados.

A API publica 8080 somente no loopback da VM. O NSG não possui regras que liberem
SSH ou HTTP de entrada. Isso permite demonstrar o container remoto pelo terminal
sem expor o CRUD sem autenticação à internet. As saídas de verify-vm.sh mostram
a VM em execução e os testes HTTP realizados dentro dela.

Integração Oracle: o mesmo JAR possui perfil oracle configurado por variáveis.
Não há execução automática de DDL Oracle. A conexão depende de schema, permissões
CRUD e conectividade com o servidor do grupo. Esse modo precisa de validação própria.

A imagem usa duas etapas: build Maven/JDK e execução JRE. A versão da fonte da API
é fixada por SHA em scripts/build-image.sh. As tags das imagens base podem mudar
com atualizações dos fornecedores; registrar os IDs/digests da imagem construída
nas evidências para identificar a execução real.
