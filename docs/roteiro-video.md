# Roteiro do vídeo

**Vídeo publicado:** https://www.youtube.com/watch?v=YWLDkvy1bto

O material abaixo foi usado como guia de gravação. O vídeo final tem 4 minutos.
A exclusão definitiva foi concluída depois da gravação; o [comprovante está aqui](../evidence/README.md#exclusão-dos-recursos).
A VM foi removida e os comandos de criação só devem ser repetidos para uma nova implantação.

Duração: cerca de 3 minutos. Grave em pelo menos 720p, com o terminal legível
e áudio ou legendas. As falas abaixo são uma sugestão; explique com suas palavras.

| Tempo | Na tela | Fala sugerida |
| --- | --- | --- |
| 0:00–0:20 | Projeto e diagrama | “Esse é o NEXO. Nesta entrega de DevOps, colocamos a API Java do grupo em um container Docker dentro de uma VM na Azure.” |
| 0:20–0:55 | Comando de criação por CLI e resultado da VM | “Este script cria o grupo, a rede e a VM Ubuntu. Aqui está o resultado da criação pela Azure CLI.” |
| 0:55–1:30 | Dockerfile, resultado do build e `docker ps` na VM | “A primeira etapa compila a API com Maven e Java 21. A segunda executa o JAR. Aqui está a imagem construída e o container funcionando dentro da VM.” |
| 1:30–2:15 | `verify-vm.sh` e respostas da API | “Os testes rodam dentro da VM pelo Run Command. Por isso, esse localhost é da Azure. Os endpoints responderam 200, e o teste CRUD também passou. Para a demonstração, usamos H2 com dados fictícios; Oracle ainda não foi testado.” |
| 2:15–2:40 | README, scripts e diagrama | “No GitHub estão os comandos para repetir a implantação, a arquitetura e os resultados. O Docker padroniza a execução da API e a Azure hospeda o ambiente.” |
| 2:40–3:00 | `cleanup.sh` e confirmação de exclusão | “Depois de salvar as evidências, apagamos o grupo de recursos. Esse retorno false confirma a exclusão.” |

Mostre os comandos **e os resultados**. Pode cortar os tempos de espera do build
e do provisionamento na edição. Deixe a exclusão para o fim, depois de guardar
as demais evidências; use a última fala somente após a exclusão ser confirmada.

Antes de gravar, feche telas que mostrem senhas, tokens, chaves ou outras credenciais.
