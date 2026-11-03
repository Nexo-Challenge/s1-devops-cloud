# Vídeo DevOps - aproximadamente 3 minutos
Gravar em no mínimo 720p, com terminal legível e áudio explicativo ou legendas.
Usar resultados reais. Não mostrar senhas, tokens, chaves ou variáveis secretas.

| Tempo | Mostrar | Fala sugerida |
| --- | --- | --- |
| 0:00-0:20 | Nome NEXO e diagrama | “O NEXO apresenta aplicações da tecnologia nuclear. Nesta entrega, hospedamos a API Java em um container Docker dentro de uma VM Azure.” |
| 0:20-0:55 | Cloud Shell: comando de provisionamento e VM running | “A infraestrutura foi criada por Azure CLI. O script organiza a VM, o disco e a rede em um grupo dedicado.” Mostrar resultado real de provision.sh, não apenas o código. |
| 0:55-1:30 | Dockerfile, build e docker ps na VM | “O build usa Maven e Java 21. A imagem de execução contém o JAR e usa um usuário sem privilégios. O container roda dentro da VM, como mostra esta saída.” |
| 1:30-2:15 | verify-vm.sh e resposta JSON | “A verificação é executada dentro da VM pelo Azure VM Agent. O endereço localhost mostrado aqui pertence à VM Azure. Os endpoints retornam HTTP 200.” Se for H2: “Esta demonstração usa H2 com dados fictícios e temporários. A conexão Oracle é uma configuração separada ainda não validada.” |
| 2:15-2:40 | README, scripts e diagrama | “O repositório documenta os passos para reproduzir o ambiente. Docker padroniza a execução e Azure oferece a infraestrutura remota.” |
| 2:40-3:00 | Exclusão real do grupo e confirmação false | “Após registrar as evidências, excluímos o grupo de recursos para encerrar o consumo desta infraestrutura.” Mostrar cleanup.sh e az group exists retornando false. |

Se a gravação do provisionamento/build exceder 3 minutos, editar as esperas e manter os comandos e os resultados visíveis. Não afirmar que Docker, VM ou exclusão foram testados enquanto faltarem suas evidências.
