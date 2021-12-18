# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN apt-get update \
  && apt-get install -y gnupg \
  && gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
  && gpg --batch --verify /tini.asc /tini \
  && chmod +x /tini

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
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Setup Tini
COPY --from=build-env /tini /
ENTRYPOINT ["/tini", "--"]

WORKDIR /app
# Copy app files
COPY --from=build-env /app/out .

CMD [ "dotnet", "$PROJECT_NAME.dll" ]
