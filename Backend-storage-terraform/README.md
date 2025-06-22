# Introduction 
The Azure storage account is used as a remote backend to store the Terraform state file (terraform.tfstate). This ensures the state is centralized, consistent, and accessible to all team members, enabling collaboration and preventing conflicts. The state is stored in a blob container within the storage account.

# Getting Started

#### 1. Setting up variables

        RESOURCE_GROUP="tfstate-RG"

        LOCATION="eastus"

        BLOB_CONTAINER_NAME="statefiles"

#### 2. Create service principal and login using it.

        az ad sp create-for-rbac --name="$SERVICE_PRINCIPAL" --role="Contributor" --scopes="subscriptions/$SUBSCRIPTION_ID" 

        az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID


#### 3. Create a resource group

        az group create --name $RESOURCE_GROUP --location $LOCATION

#### 3. Create storage account

        az storage account create --name $STORAGEACCOUNT_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS --kind StorageV2 --allow-blob-public-access "false

#### 4. Get the storage key

        az storage account keys list --account-name $STORAGEACCOUNT_NAME --resource-group $RESOURCE_GROUP --query '[0].value' --output tsv

#### 5. Create blob container for the terraform state.

        az storage container create --name $BLOB_CONTAINER_NAME --account-name $STORAGEACCOUNT_NAME --account-key $ACCOUNT_KEY


# Build and Test
 
All the above commands are included in a script and can be executed as part of the setup process.


##### __Errors encountered__

No subscriptions found for <Service_Principal_AppId>

__Solution__

        az logout
        az login
        az cache purge
