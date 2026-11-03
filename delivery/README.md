# Entrega final — Sprint 1

DevOps Tools & Cloud Computing — FIAP / Challenge AMAZUL. **Turma: 2TDSPS**.

## Links da entrega

- [Repositório com o código, scripts e documentação](https://github.com/Nexo-Challenge/s1-devops-cloud).
- [Vídeo da demonstração no YouTube](https://www.youtube.com/watch?v=YWLDkvy1bto).
- [Baixar o PDF final](NEXO-DevOps-Entrega-Final.pdf).
- [Comprovante da exclusão dos recursos da Azure](../evidence/README.md#exclusão-dos-recursos).

O PDF reúne os integrantes, RMs, turma, links clicáveis, arquitetura e comprovante
de exclusão. O vídeo publicado tem 4 minutos, resolução de 720p e áudio explicativo.
O roteiro original previa cerca de 3 minutos.

## Equipe

| Integrante | RM |
| --- | --- |
| Alisson Kawan Evangelista Silva | 567598 |
| Kenji Fernandes Wakabayashi | 568156 |
| Erick Ramos Santos | 567837 |
| Eduardo Boni dos Santos | 567236 |
| Marcos Vinicius de Jesus Almeida | 567214 |

## Situação da entrega

A API Java foi executada em um container Docker dentro da VM Azure e passou pelos
testes HTTP e CRUD. O código está na branch `main`, após a integração do
[PR #2](https://github.com/Nexo-Challenge/s1-devops-cloud/pull/2).

Após a gravação, o grupo `rg-nexo-sprint1` foi excluído em **03/11/2026** pelo portal
Azure. A confirmação real está nas evidências e no PDF. A tentativa de limpeza
mostrada no final do vídeo foi cancelada por uma confirmação digitada incorretamente;
a exclusão definitiva ocorreu depois.

A documentação e o vídeo ficam disponíveis para avaliação; a VM foi removida ao
encerrar a demonstração. A demonstração usa H2 em memória com dados fictícios.
Oracle não foi acessado nem validado nesta etapa.

O PDF está pronto para ser enviado no portal da disciplina. A submissão no portal
fica a cargo do grupo.
