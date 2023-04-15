# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

# Add Tini
ENV TINI_VERSION v0.19.0
RUN wget -q -O - https://raw.githubusercontent.com/kaykayehnn/Dockerfiles/main/common/download-tini.sh | sh

WORKDIR /app

# OPTIONAL SECTION 1 ##########################################################

# # Install dotnet tools
# COPY .config ./
# RUN dotnet tool restore

# END OPTIONAL SECTION 1 ######################################################

# Install NuGet packages
COPY *.csproj ./
RUN dotnet restore

# Build project
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0

# Setup Tini
COPY --from=build-env /tini /
ENTRYPOINT ["/tini", "--"]

WORKDIR /app
# Copy app files
COPY --from=build-env /app/out .

# Change this to your project name
CMD [ "dotnet", "_NET.dll" ]
