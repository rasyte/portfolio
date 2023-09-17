@echo off
REM Setting variables
set SUBSCRIPTION_NAME="Visual Studio Enterprise Subscription"
set RESOURCE_GROUP="rrresources"
set LOCATION="East US"
set APP_SERVICE_PLAN="rrappserviceplan"
set WEB_APP="rrportfolio"

echo Logging into Azure
az login

echo Setting the subscription
az account set --subscription %SUBSCRIPTION_NAME%

echo Creating a new resource group
az group create --name %RESOURCE_GROUP% --location %LOCATION%

echo Creating a new app service plan
az appservice plan create --name %APP_SERVICE_PLAN% --resource-group %RESOURCE_GROUP% --location %LOCATION% --sku B1 --is-linux

echo "Web app %WEB_APP% has been created successfully!"