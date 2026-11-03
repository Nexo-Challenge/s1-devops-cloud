# Conferência da entrega — Sprint 1

DevOps Tools & Cloud Computing, conforme a seção DevOps 01–05 do PDF
`2TDS Agosto - Marinha 2026 - 1º Semestre V2.pdf`.

| Item | Onde conferir |
| --- | --- |
| Arquitetura com ícones, serviços e comunicação | [Diagrama e explicação](arquitetura/README.md) |
| Dockerfile e construção da imagem | [Dockerfile](../docker/Dockerfile), [build](../scripts/build-image.sh) e [instruções](../docker/README.md) |
| Container executando na VM Azure | [Vídeo](https://www.youtube.com/watch?v=YWLDkvy1bto) e [validação](validacao.md) |
| Provisionamento por Azure CLI | [provision.sh](../azure/provision.sh) e [comandos](../azure/README.md) |
| Scripts de implantação e teste | [Azure](../azure/) e [scripts](../scripts/) |
| Nomes, RMs, turma e explicação Docker/Cloud | [README principal](../README.md) |
| Exclusão dos recursos após a demonstração | [Comprovante do portal Azure](../evidence/README.md#exclusão-dos-recursos) |
| Vídeo publicado, 720p, com áudio | [YouTube](https://www.youtube.com/watch?v=YWLDkvy1bto) |
| PDF com integrantes, RMs, turma e links | [PDF final](../delivery/NEXO-DevOps-Entrega-Final.pdf) |

O código e a documentação estão na `main`. A implantação foi criada por CLI;
a exclusão definitiva foi concluída pelo portal Azure em 03/11/2026.

## Observações sobre a demonstração

O vídeo publicado tem 4 minutos; o enunciado pede aproximadamente 3 minutos.
A tentativa final de limpeza no vídeo foi cancelada por erro de confirmação.
O comprovante da exclusão posterior está no repositório e no PDF.

O `localhost` dos testes pertence à VM Azure. A API estava hospedada na nuvem,
sem portas HTTP ou SSH abertas para a internet. O banco usado foi H2 em memória,
com dados fictícios; a integração Oracle não foi testada.

Esta conferência indica onde estão os itens e evidências, sem substituir a
avaliação do professor. O envio do PDF no portal da disciplina deve ser feito pelo grupo.
