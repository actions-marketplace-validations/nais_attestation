#!/bin/sh -l

DOCKER_REGISTRY="${INPUT_IMAGE%%/*}"

docker version

echo "docker login:"

echo "$INPUT_DOCKER_PWD" | docker login "$DOCKER_REGISTRY" -u "$INPUT_DOCKER_USER" --password-stdin

echo "syft attest:"

echo "${INPUT_KEY_PWD}" | syft attest --key "${INPUT_KEY}" "${INPUT_IMAGE}"

echo "printing sbom file:"
cat sbom.json
ls -la

#cosign attach attestation --attestation sbom.json "${INPUT_IMAGE}"
