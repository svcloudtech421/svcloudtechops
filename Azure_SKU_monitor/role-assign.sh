# Get your username first
USER_PRINCIPAL=$(az ad signed-in-user show --query userPrincipalName -o tsv)
echo "Looks like you're logged in as: $USER_PRINCIPAL"

# Create a resource group - you can change the name if you want
az group create --name vm-sku-monitor-rg --location eastus2

# Give yourself the right permissions
az role assignment create \
  --assignee "$USER_PRINCIPAL" \
  --role "Monitoring Metrics Publisher" \
  --scope "/subscriptions/$(az account show --query id -o tsv)/resourcegroups/vm-sku-monitor-rg"

# Double-check it worked
az role assignment list \
  --assignee "$USER_PRINCIPAL" \
  --role "Monitoring Metrics Publisher" \
  --scope "/subscriptions/$(az account show --query id -o tsv)/resourcegroups/vm-sku-monitor-rg"
#assign vm system assign to rear
az role assignment create \
  --assignee-object-id b2a9064a-a041-4a14-8499-b91440b2cb84 \
  --role Reader \
  --scope /subscriptions/6530f7de-a552-4135-9564-bbd59b7ccf8d
