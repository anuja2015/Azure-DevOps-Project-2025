#!/bin/bash

set -x

## Set variables ##

RESOURCE_GROUP="tfstate-RG"
LOCATION="canadacentral"
BLOB_CONTAINER_NAME="statefiles"

## Get a random name for storage account ##

RANDOM_ID=$RANDOM
STORAGEACCOUNT_NAME="tfstate${RANDOM_ID}"

## Authenticating with Azure ##

az login

SUBSCRIPTION_ID=$(az account show --query id --output tsv)
SERVICE_PRINCIPAL="tf-backend-sp"
#az account set --subscription $SUBSCRIPTION_ID

## Create serviceprincipal ##

az ad sp create-for-rbac --name="$SERVICE_PRINCIPAL" --role="Contributor" --scopes="subscriptions/$SUBSCRIPTION_ID" > sp.txt

## Extract secret values ##

APP_ID=$(grep appId sp.txt | cut -d: -f2 | tr -d ' " ' | tr -d ',')
CLIENT_SECRET=$(grep password sp.txt | cut -d: -f2 | tr -d ' " ' | tr -d ',')
TENANT_ID=$(grep tenant sp.txt | cut -d: -f2 | tr -d ' " ' | tr -d ',')

az account set --subscription $SUBSCRIPTION_ID

az role assignment create --assignee $APP_ID --role "Contributor" --scope subscriptions/$SUBSCRIPTION_ID

az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID


echo " Creating the resource group for storage account : $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Creating storage account $STORAGEACCOUNT_NAME"
az storage account create --name $STORAGEACCOUNT_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS --kind StorageV2 --allow-blob-public-access "false" 

## Get account key ##
ACCOUNT_KEY=$(az storage account keys list --account-name $STORAGEACCOUNT_NAME --resource-group $RESOURCE_GROUP --query '[0].value' --output tsv 2>/dev/null)

STORAGE_CREATE_STATUS=$?

## Create container $BLOB_CONTAINER_NAME ##

az storage container create --name $BLOB_CONTAINER_NAME --account-name $STORAGEACCOUNT_NAME --account-key $ACCOUNT_KEY

CONTAINER_CREATE_STATUS=$?

if [ $STORAGE_CREATE_STATUS -eq 0 ] && [ $CONTAINER_CREATE_STATUS -eq 0 ]; then

  echo "Azure Storage backend created successfully."

else

  echo "Storage account creation failed. Exiting."
  exit 1
fi
