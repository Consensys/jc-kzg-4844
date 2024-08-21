#!/bin/bash

set -euo pipefail

JAR=${1:?Must specify path to an already built jc-kzg-4844 jar file}

# exclude directories and the manifest file
JAR_FILES=$(jar tvf "${JAR}" | grep -Ev "(/|MANIFEST.MF)$")

EXPECTED_FILES="ethereum/ckzg4844/CKZG4844JNI.class
ethereum/ckzg4844/CKZGException\$CKZGError.class
ethereum/ckzg4844/CKZGException.class
ethereum/ckzg4844/CellsAndProofs.class
ethereum/ckzg4844/ProofAndY.class
ethereum/ckzg4844/lib/amd64/libckzg4844jni.so
ethereum/ckzg4844/lib/aarch64/libckzg4844jni.so
ethereum/ckzg4844/lib/amd64/ckzg4844jni.dll
ethereum/ckzg4844/lib/x86_64/libckzg4844jni.dylib
ethereum/ckzg4844/lib/aarch64/libckzg4844jni.dylib"

EXIT_CODE=0

for FILE in $EXPECTED_FILES; do
  echo -n "Checking for $FILE: "
  if [[ "$JAR_FILES" == *"$FILE"* ]]; then
    echo "Present"
  else
    echo "Missing!"
    EXIT_CODE=1
  fi
done

if [[ $EXIT_CODE -eq 0 ]]; then
  EXPECTED_FILES_COUNT=$(echo "${EXPECTED_FILES}" | wc -l)
  JAR_FILES_COUNT=$(echo "${JAR_FILES}" | wc -l)
  if [ "$EXPECTED_FILES_COUNT" -ne "$JAR_FILES_COUNT" ]; then
    echo "Expected number of files in the jar to be ${EXPECTED_FILES_COUNT}, but it was ${JAR_FILES_COUNT}."
    echo "Files in the jar:"
    echo "${JAR_FILES}"
    EXIT_CODE=1
  fi
fi

exit $EXIT_CODE
