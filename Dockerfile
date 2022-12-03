# Build project BlobbyVolleyWorld.MasterServer
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

RUN mkdir /app
RUN mkdir /src

WORKDIR /src

COPY . .

RUN dotnet restore "BlobbyVolleyWorld.MasterServer/BlobbyVolleyWorld.MasterServer.csproj"

WORKDIR "/src/BlobbyVolleyWorld.MasterServer"

RUN dotnet build "BlobbyVolleyWorld.MasterServer.csproj" -c Release -o /app/build

FROM build AS publish

RUN dotnet publish "BlobbyVolleyWorld.MasterServer.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/runtime:6.0 AS final

WORKDIR /app

COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "BlobbyVolleyWorld.MasterServer.dll"]
