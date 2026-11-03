# NEXO - Docker e VM Azure

Entrega de DevOps Tools & Cloud Computing - Sprint 1, FIAP / Challenge AMAZUL.

A API Java é empacotada em uma imagem Docker e executada em uma VM Ubuntu na Azure.
O modo demo usa H2 temporário com dados fictícios. O perfil Oracle continua disponível
para integração posterior com o banco do grupo.

**Estado:** imagem Docker construída e API executada e testada em uma VM Azure real.
A API Java teve 61 testes aprovados previamente. A verificação remota passou em HTTP e CRUD,
inclusive após reiniciar o container. Ver [resultados e pendências](docs/validacao.md).

## Começar

- [Docker local](docker/README.md): construir a imagem, iniciar e testar a API.
- [Azure por CLI](azure/README.md): criar a VM, implantar e verificar o container remoto.
- [Arquitetura](docs/arquitetura/README.md): fluxo e diagrama com ícones.

![Arquitetura NEXO na Azure](docs/arquitetura/arquitetura.svg)

- [Roteiro do vídeo](docs/roteiro-video.md): aproximadamente 3 minutos.
- [Evidências](evidence/README.md) e [entrega final](delivery/README.md).

## Como Docker e Cloud Computing podem ser utilizados na solução?

Docker reúne a API Java, seu runtime e sua configuração de execução em uma imagem,
reduzindo diferenças entre máquinas. O build em múltiplas etapas usa Maven/JDK para
gerar o JAR e um JRE para executá-lo. O processo roda com usuário sem privilégios.

Cloud Computing fornece a VM e a rede remotas para hospedar o container. Azure CLI
permite repetir o provisionamento por script e registrar os comandos usados. A API
pode atender o aplicativo do NEXO quando sua integração estiver implementada.
Nesta demonstração, os testes são executados dentro da VM via Azure VM Agent;
o endereço 127.0.0.1 pertence à VM, e a aplicação não fica exposta à internet.

## Reprodutibilidade

Fonte Java fixada em `b277672b3ed25ac2bd2970fbd6824dc3d38bae86` do
[s1-java-api](https://github.com/Nexo-Challenge/s1-java-api).
Scripts de infraestrutura versionados neste repositório. Imagens base:
`maven:3.9.11-eclipse-temurin-21` e `eclipse-temurin:21-jre-jammy`.
Registrar IDs e digests reais nas evidências. O build Docker usa `-DskipTests`;
a suíte Java e o teste HTTP/CRUD têm evidências separadas.

## Equipe e responsabilidade

| Nome Completo | RM | Turma | Responsabilidade Principal |
| :--- | :--- | :--- | :--- |
| **Alisson Kawan Evangelista Silva** | **RM567598** | 2TDSPS | Java e .NET |
| **Kenji Fernandes Wakabayashi** | **RM568156** | 2TDSPS | IoT e Banco de Dados |
| **Erick Ramos Santos** | **RM567837** | 2TDSPS | DevOps Tools & Cloud Computing (Responsável Principal) |
| **Eduardo Boni dos Santos** | **RM567236** | 2TDSPS | Mobile Application Development |
| **Marcos Vinicius de Jesus Almeida** | **RM567214** | 2TDSPS | Documentação e Qualidade de Software (QA) |

Turma: **2TDSPS**. Nomes completos, RMs e turma conferidos nos READMEs de
[banco de dados](https://github.com/Nexo-Challenge/s1-database#equipe-e-responsabilidade)
e [mobile](https://github.com/Nexo-Challenge/s1-mobile-flutter#equipe-e-responsabilidade).

## Fonte e prazo
Fonte: `2TDS Agosto - Marinha 2026 - 1º Semestre V2.pdf`, seção **DevOps Tools & Cloud Computing 01–05**, fornecido pelo grupo. O PDF original não foi republicado.

O documento diverge: seção Entregas indica **01/11/2026**, Cronograma indica **até 02/11/2026**. Confirmar data e horário no portal/professor; nenhuma das datas foi validada como definitiva. Documentar eventuais instruções atualizadas do portal.

## Documentação de referência

- [Requisitos da Sprint 1](docs/requisitos-sprint-1.md).
- [Criar VM Linux por Azure CLI](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-cli).
- [Docker Engine no Ubuntu](https://docs.docker.com/engine/install/ubuntu/).
- [CONTRIBUTING.md](CONTRIBUTING.md).

## Cuidados operacionais

A demonstração H2 perde os dados ao reiniciar; ela não comprova integração Oracle.
A VM, o disco e o IP podem consumir créditos. Guardar as evidências e gravar o vídeo
antes de executar o script de exclusão. Nenhuma credencial deve entrar no Git.
VM e container já foram verificados. A entrega ainda depende de GitHub atualizado, vídeo publicado,
PDF preenchido e evidência da exclusão.
