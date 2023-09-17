@echo off
setlocal

:: Define variables
set REPOSITORY=rrportfolioimages
set REGISTRY_NAME=codebougiecontainers
set REGISTRY_URL=codebougiecontainers.azurecr.io
set IMAGE_NAME=%REGISTRY_URL%/%REPOSITORY%
set TAG=latest
set RESOURCE_GROUP=rrresources
set APP_SERVICE_PLAN=rrappserviceplan
set WEB_APP_NAME=rrportfolio

echo Getting Azure Container Registry credentials...
for /f "delims=" %%a in ('az acr credential show --name %REGISTRY_NAME% --query "username" --output tsv') do set USERNAME=%%a
for /f "delims=" %%a in ('az acr credential show --name %REGISTRY_NAME% --query "passwords[0].value" --output tsv') do set PASSWORD=%%a

echo Logging in to Azure Container Registry...
call docker login %REGISTRY_URL% --username %USERNAME% --password %PASSWORD%

echo Building the Docker image...
call docker build -t %IMAGE_NAME%:%TAG% .

echo Pushing the Docker image to Azure Container Registry...
call docker push %IMAGE_NAME%:%TAG%

echo Deploying the web app from the container image...
call az webapp create --name %WEB_APP_NAME% --resource-group %RESOURCE_GROUP% --plan %APP_SERVICE_PLAN% --deployment-container-image-name %IMAGE_NAME%:%TAG%

echo Restarting web app...
call az webapp restart --name %WEB_APP_NAME% --resource-group %RESOURCE_GROUP%

:: Clean up if necessary
:: echo Logging out from Azure Container Registry...
:: call docker logout %REGISTRY_URL%

echo Script finished successfully!
endlocal
