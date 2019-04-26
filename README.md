# IC-Infraestructure

## Terraform

```bash

# Iniciar el repositorio

terraform init

# Aplicar los cambios

terraform apply

# Ver el estado actual

terraform state show

# Destruir la infraestructura actual

terraform destroy

# Leer los valores de una variable output

terraform output ip

```

# Azure Container Registry

```json
// Información del ACR

{
  "adminUserEnabled": false,
  "creationDate": "2019-04-10T03:21:24.218877+00:00",
  "id": "/subscriptions/0f67879f-3204-4b31-94c7-28a69136a4a2/resourceGroups/CalculatorAKS-RG/providers/Microsoft.ContainerRegistry/registries/CalculatorACR",
  "location": "centralus",
  "loginServer": "calculatoracr.azurecr.io",
  "name": "CalculatorACR",
  "networkRuleSet": null,
  "provisioningState": "Succeeded",
  "resourceGroup": "CalculatorAKS-RG",
  "sku": {
    "name": "Basic",
    "tier": "Basic"
  },
  "status": null,
  "storageAccount": null,
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries"
}

```

```json
// Asignación de permisos

{
  "canDelegate": null,
  "id": "/subscriptions/0f67879f-3204-4b31-94c7-28a69136a4a2/resourceGroups/CalculatorAKS-RG/providers/Microsoft.ContainerRegistry/registries/CalculatorACR/providers/Microsoft.Authorization/roleAssignments/9feb847f-e28b-4981-9d3b-d68eb57f71aa",
  "name": "9feb847f-e28b-4981-9d3b-d68eb57f71aa",
  "principalId": "bf79c81b-8767-4ec1-97a4-7ec8844eadb6",
  "resourceGroup": "CalculatorAKS-RG",
  "roleDefinitionId": "/subscriptions/0f67879f-3204-4b31-94c7-28a69136a4a2/providers/Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d",
  "scope": "/subscriptions/0f67879f-3204-4b31-94c7-28a69136a4a2/resourceGroups/CalculatorAKS-RG/providers/Microsoft.ContainerRegistry/registries/CalculatorACR",
  "type": "Microsoft.Authorization/roleAssignments"
}
```

```bash
# Subiendo la aplicación al ACR
docker tag calculator calculatoracr.azurecr.io/calculator:v0.1
docker push calculatoracr.azurecr.io/calculator:v0.1
```


# Jenkins

Open a browser to http://23.100.84.51:8080
Enter the following to Unlock Jenkins:
f6ee230488184abc9db24f6bc9aa4db3

username: vanhalt
password: Jenkins.com1234

```json

// jenkins user

{
  "appId": "63dc3c10-862f-43db-bf4f-55bca13b43d8",
  "displayName": "azure-cli-2019-04-10-04-48-04",
  "name": "http://azure-cli-2019-04-10-04-48-04",
  "password": "e74ac902-4bb4-40ca-93ca-c8cc34d2a5ed",
  "tenant": "dbe6faae-d61d-441e-8cd7-616c5947bbc0"
}

ACR_ID=$(az acr show --resource-group CalculatorAKS-RG --name CalculatorACR --query "id" --output tsv)

az role assignment create --assignee 63dc3c10-862f-43db-bf4f-55bca13b43d8 --role Contributor --scope $ACR_ID

// resultado del comando de arriba

{
  "canDelegate": null,
  "id": "/subscriptions/0f67879f-3204-4b31-94c7-28a69136a4a2/resourceGroups/CalculatorAKS-RG/providers/Microsoft.ContainerRegistry/registries/CalculatorACR/providers/Microsoft.Authorization/roleAssignments/eabc1110-4090-4a8d-955a-d02ea3aa5798",
  "name": "eabc1110-4090-4a8d-955a-d02ea3aa5798",
  "principalId": "71fe9045-202d-4703-92c9-a333d86cb4c4",
  "resourceGroup": "CalculatorAKS-RG",
  "roleDefinitionId": "/subscriptions/0f67879f-3204-4b31-94c7-28a69136a4a2/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
  "scope": "/subscriptions/0f67879f-3204-4b31-94c7-28a69136a4a2/resourceGroups/CalculatorAKS-RG/providers/Microsoft.ContainerRegistry/registries/CalculatorACR",
  "type": "Microsoft.Authorization/roleAssignments"
}

```

# Pruebas con cURL

```bash

# Suma
curl http://40.122.30.209/sum -d 'a=1&b=5'

# Resta
curl http://40.122.30.209/substract -d 'a=4&b=3'

```