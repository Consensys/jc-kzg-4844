#!/bin/bash

set -euo pipefail

export PATH="$JAVA_HOME/bin:$PATH"

JAR=${1:?Must specify path to an already built jc-kzg-4844 jar file}

CONTENTS=$(jar tvf "${JAR}")

EXPECTED="ethereum/ckzg4844/CKZG4844JNI.class
ethereum/ckzg4844/lib/amd64/mainnet/libckzg4844jni.so
ethereum/ckzg4844/lib/aarch64/mainnet/libckzg4844jni.so
ethereum/ckzg4844/lib/amd64/mainnet/ckzg4844jni.dll
ethereum/ckzg4844/lib/x86_64/mainnet/libckzg4844jni.dylib
ethereum/ckzg4844/lib/aarch64/mainnet/libckzg4844jni.dylib
ethereum/ckzg4844/lib/amd64/minimal/libckzg4844jni.so
ethereum/ckzg4844/lib/aarch64/minimal/libckzg4844jni.so
ethereum/ckzg4844/lib/amd64/minimal/ckzg4844jni.dll
ethereum/ckzg4844/lib/x86_64/minimal/libckzg4844jni.dylib
ethereum/ckzg4844/lib/aarch64/minimal/libckzg4844jni.dylib"

EXPECTED_TOTAL_FILES=11

EXIT_CODE=0

for LIB in $EXPECTED; do
  echo -n "Checking for $LIB: "
  if [[ "$CONTENTS" == *"$LIB"* ]]; then
    echo "Present"
  else
    echo "Missing!"
    EXIT_CODE=1
  fi
done

# check there are no other unexpected files in the jar
if [[ $EXIT_CODE -eq 0 ]]; then
  TOTAL_FILES=$(echo "${CONTENTS}" | grep -Ecv "(/|MANIFEST.MF)$")
ó
  if [ "$TOTAL_FILES" -ne $EXPECTED_TOTAL_FILES ]; then
    echo "Expected total number of files in the jar to be ${EXPECTED_TOTAL_FILES}, but it was ${TOTAL_FILES}"
    EXIT_CODE=1
  fi
fi

exit $EXIT_CODE
