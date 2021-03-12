FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build-env
RUN mkdir /app
WORKDIR /app

# copy the project and restore as distinct layers in the image
COPY ./ ./
RUN dotnet restore --no-cache ApiMonitoring/ApiMonitoring.csproj

# copy the rest and build
COPY ./ ./
RUN dotnet build ApiMonitoring/ApiMonitoring.csproj
RUN dotnet publish -c Release -o out

# build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
RUN mkdir /app
WORKDIR /app

COPY --from=build-env /app/out ./
ENTRYPOINT ["dotnet", "ApiMonitoring.dll"]
