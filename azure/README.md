# Rodando na Azure

Os comandos abaixo usam o Azure Cloud Shell em **Bash**. Antes de criar recursos,
confira a assinatura, os créditos, a região permitida e a quota disponível.

## Estado da demonstração

O grupo `rg-nexo-sprint1` foi excluído em **03/11/2026**, após a gravação.
O [comprovante](../evidence/README.md#exclusão-dos-recursos) está no repositório.
Os comandos abaixo criam uma nova implantação e voltam a consumir recursos da assinatura.

## Criar o ambiente

Este passo é para uma nova implantação. Se `rg-nexo-sprint1` já existir, confira
o ambiente antes de repetir a criação. O script interrompe essa etapa para preservar os recursos.

Confira as assinaturas e informe o ID da que será usada:

```bash
az account list -o table
export AZURE_SUBSCRIPTION_ID="ID_DA_ASSINATURA_ESCOLHIDA"
export NEXO_RG="rg-nexo-sprint1"
export NEXO_LOCATION="eastus"
export NEXO_VM_SIZE="Standard_D2s_v4"
```

Obtenha o repositório e execute na ordem abaixo. O exemplo pressupõe que a pasta
`s1-devops-cloud` ainda não existe no Cloud Shell:

```bash
git clone https://github.com/Nexo-Challenge/s1-devops-cloud.git
cd s1-devops-cloud
bash azure/provision.sh
bash azure/auto-shutdown.sh
bash azure/deploy.sh
bash azure/verify-vm.sh
```

A configuração padrão cria Ubuntu 22.04, 2 vCPU, 8 GiB de RAM e disco Standard_LRS
de 30 GB. Se faltar quota ou o tamanho não estiver disponível, confira as opções
da assinatura antes de tentar novamente.

O deploy envia os arquivos locais por Run Command, confere o pacote por SHA-256
e faz o build na VM. A primeira execução demora mais para instalar Docker e baixar
as dependências. Não depende de merge no GitHub. Se `/opt/nexo-devops` já existir,
confira a implantação anterior; o script não substitui essa pasta automaticamente.

## Conferir a API e os logs

```bash
bash azure/verify-vm.sh
az vm run-command invoke -g "$NEXO_RG" -n vm-nexo-sprint1 --command-id RunShellScript \
  --scripts 'docker ps -a; docker logs --tail 80 nexo-api' --query 'value[].message' -o tsv
```

A API atende em `127.0.0.1:8080` **dentro da VM**. Os testes usam o agente da Azure,
sem abrir portas HTTP ou SSH para a internet. Esta demonstração usa H2 e não recebe
credenciais Oracle.

## Desligamento e exclusão

Sem configuração extra, `auto-shutdown.sh` agenda o desligamento para duas horas
depois da execução. O horário é salvo em UTC e se repete diariamente.
Para escolher um horário, defina `NEXO_SHUTDOWN_UTC` antes de executar o script.
Na implantação de 02/11, ficou configurado `0300` UTC, equivalente a 00h em São Paulo.
Esse agendamento já foi removido junto com o grupo.

Desligar a VM mantém o disco e o IP, que podem continuar consumindo créditos.
Depois de gravar o vídeo e salvar as evidências, exclua o grupo:

```bash
bash azure/cleanup.sh
```

O script mostra os recursos e pede o nome do grupo para confirmar. Ao terminar,
confere se `az group exists` retorna `false`. Guarde esse resultado para a entrega.

Na demonstração entregue, a tentativa de execução do script foi cancelada por erro
na confirmação. A limpeza final foi concluída pelo portal Azure. Para futuras
execuções do script, digite **somente `rg-nexo-sprint1`** quando ele pedir o nome;
não digite um comando nesse campo.
