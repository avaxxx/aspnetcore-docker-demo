FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS builder

WORKDIR /src/web
COPY src/web/web.csproj .
RUN dotnet restore

COPY src/web/ .
RUN dotnet publish -c Release -o /out web.csproj

# app image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim-arm32v7

WORKDIR /app
ENTRYPOINT ["dotnet", "web.dll"]

COPY --from=builder /out/ .