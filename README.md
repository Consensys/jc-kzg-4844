# jc-kzg-4844

[![Build Status](https://circleci.com/gh/ConsenSys/jc-kzg-4844.svg?style=svg)](https://circleci.com/gh/ConsenSys/workflows/jc-kzg-4844)
[![GitHub license](https://img.shields.io/github/license/ConsenSys/jc-kzg-4844.svg)](https://github.com/ConsenSys/jc-kzg-4844/blob/master/LICENSE)

Java wrapper around [C-KZG-4844](https://github.com/ethereum/c-kzg-4844)

⚠️ This project is still WIP.

# Dependency

```groovy
repositories {
    maven { url "https://artifacts.consensys.net/public/maven/maven/" }
}

dependencies {
    implementation("tech.pegasys:jc-kzg-4844:<version>")
}
```

# Minimal Sample

```java
CKZG4844JNI.loadNativeLibrary(Preset.MAINNET);

CKZG4844JNI.loadTrustedSetup("trusted-setup.txt");

byte[] blob = ...;
byte[] commitment = CKZG4844JNI.blobToKzgCommitment(blob);
byte[] proof = CKZG4844JNI.computeAggregateKzgProof(blob, 1);

boolean isValidProof = CKZG4844JNI.verifyAggregateKzgProof(blob, commitment, 1, proof);

CKZG4844JNI.freeTrustedSetup();
```

# Supported platforms

- x86-64
    - Windows
    - Linux
    - MacOS
- aarch64
    - Linux
    - MacOS