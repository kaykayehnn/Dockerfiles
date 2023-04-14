#!/usr/bin/env sh
# This script attempts to find the most appropriate tini version depending on
# the container properties (CPU architecture and distro).

set -euo pipefail

TINI_VERSION="${TINI_VERSION:-v0.19.0}"

# The user can specify the TINI_RELEASE variable to manually pick which version
# of tini they want to use.
if [ -z "${TINI_RELEASE}" ]; then
  # This switch case statement is incomplete, though it should cover the majority
  # of use cases. PRs to improve it are very welcome
  case "$(uname -m)" in
    "aarch64")
    cpu_architecture="arm64";;
    "x86_64")
    cpu_architecture="amd64";;
  esac

  if [ "${TINI_STATIC}" = "1" ] || [ "${TINI_STATIC}" = "true" ]; then
    static="-static"
  fi

  TINI_RELEASE="tini${static:-}-${cpu_architecture}"
fi

. /etc/os-release

downloadUrl="https://github.com/krallin/tini/releases/download/${TINI_VERSION}/${TINI_RELEASE}"

wget -q "$downloadUrl" -O /tini
wget -q "$downloadUrl.asc" -O /tini.asc

# PRs to extend this list are also welcome
if [ "$ID" = "alpine" ]; then
  apk add --no-cache gnupg \
    && gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
    && gpg --batch --verify /tini.asc /tini \
    && chmod +x /tini
elif [ "$ID" = "debian" ] || [ "$ID" = "ubuntu" ]; then

fi
