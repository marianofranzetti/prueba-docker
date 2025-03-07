FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:4d4bfe1b2d8b3cbdafdbd1bb946dc5d8c5e56db71df52d7dc4cfb66b3945b1dc AS build
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0@sha256:c2b5f40e74f6a52859a1f2a7592b9e599c789f0629f9ad5d3a5dcd52007b8f56
WORKDIR /App
COPY --from=build /App/out .
ENTRYPOINT ["dotnet", "WebApi.dll"]


#docker run -p 4201:4200 angular-docker-2


#weather-forecast/weather