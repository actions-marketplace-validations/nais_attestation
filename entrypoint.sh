#!/bin/sh -l

DOCKER_REGISTRY="${INPUT_IMAGE%%/*}"

echo "$INPUT_DOCKER_PWD" | docker login "$DOCKER_REGISTRY" -u "$INPUT_DOCKER_USER" --password-stdin

echo "${INPUT_KEY_PWD}" | syft attest "${INPUT_IMAGE}" -o json=sbom.json --key "${INPUT_KEY}"

cosign attach attestation --attestation sbom.json "${INPUT_IMAGE}"
