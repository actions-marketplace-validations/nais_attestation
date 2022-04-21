#!/bin/sh -l
set -e

DOCKER_REGISTRY="${INPUT_IMAGE%%/*}"

docker version

echo "$INPUT_DOCKER_PWD" | docker login "$DOCKER_REGISTRY" -u "$INPUT_DOCKER_USER" --password-stdin
echo "${INPUT_KEY}" > cosign.key
echo "${INPUT_KEY_PWD}" | syft attest -o spdx-json "${INPUT_IMAGE}" > sbom.json

cosign attach attestation --attestation sbom.json "${INPUT_IMAGE}"
