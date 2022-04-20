#!/bin/sh -l

DOCKER_REGISTRY="${INPUT_IMAGE%%/*}"

echo "$INPUT_DOCKER_PWD" | docker login "$DOCKER_REGISTRY" -u "$INPUT_DOCKER_USER" --password-stdin

echo "${INPUT_KEY_PWD}" | syft attest --key "${INPUT_KEY}" "${INPUT_IMAGE}" > sbom.json && echo "\n" >> sbom.json

cosign attach attestation --attestation sbom.json "${INPUT_IMAGE}"
