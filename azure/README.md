# VM Azure por CLI
Executar no Azure Cloud Shell em modo Bash. A criação consome créditos conforme assinatura,
região, tamanho, disco e IP. Conferir créditos/quotas e região permitida antes de executar.
Nenhum script faz login, troca credenciais ou aceita termos.

1. Abrir Cloud Shell autenticado e conferir: `az account list -o table`.
2. Escolher a assinatura e definir:
```bash
export AZURE_SUBSCRIPTION_ID="ID_DA_ASSINATURA_ESCOLHIDA"
export NEXO_RG="rg-nexo-sprint1"
export NEXO_LOCATION="eastus"
export NEXO_VM_SIZE="Standard_D2s_v4"
```
3. Enviar NEXO-DevOps-preparado.zip pelo botão de upload do Cloud Shell e extrair:
```bash
unzip NEXO-DevOps-preparado.zip
cd NEXO-DevOps
bash azure/provision.sh
bash azure/auto-shutdown.sh
bash azure/deploy.sh
bash azure/verify-vm.sh
```
4. Gravar o vídeo e guardar os resultados reais em evidence.
5. Após confirmar que as evidências estão salvas, executar `bash azure/cleanup.sh`.

A VM padrão é Ubuntu 22.04, Standard_D2s_v4 (2 vCPU e 8 GiB), disco Standard_LRS de 30 GB.
O desligamento é programado para duas horas após a execução do script e se repete
diariamente no horário UTC registrado. Ele encerra a execução da VM; disco e IP
continuam alocados até a exclusão do grupo. Conferir a programação após criar.
Disponibilidade e preço dependem da assinatura/região; nenhum preço é presumido.
Se houver erro de quota/tamanho/região, consultar as opções da assinatura antes de repetir.
Se o grupo já tiver sido criado parcialmente, o script para; inspecionar o grupo
e o erro antes de tentar outra criação. Não remover recursos alheios para contornar erros.

O deploy usa Run Command e envia um pacote local dos scripts/configurações, verificado por SHA-256. Não exige que os arquivos já estejam publicados no GitHub. Sua primeira execução pode demorar por instalar Docker
e baixar dependências. Não interromper a operação antes de receber o resultado.
Se o diretório /opt/nexo-devops já existir, investigar a implantação anterior;
os scripts não o substituem automaticamente.

Para ver logs na VM:
```bash
az vm run-command invoke -g "$NEXO_RG" -n vm-nexo-sprint1 --command-id RunShellScript \
  --scripts 'docker ps -a; docker logs --tail 80 nexo-api' --query 'value[].message' -o tsv
```
Não gravar logs com segredos. Os scripts de demonstração não recebem credenciais Oracle.
