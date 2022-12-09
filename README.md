# jc-kzg-4844

[![Build Status](https://circleci.com/gh/ConsenSys/jc-kzg-4844.svg?style=svg)](https://circleci.com/gh/ConsenSys/workflows/jc-kzg-4844)
[![Latest version of 'jc-kzg-4844' @ Cloudsmith](https://api-prd.cloudsmith.io/v1/badges/version/consensys/maven/maven/jc-kzg-4844/latest/a=noarch;xg=tech.pegasys/?render=true&show_latest=true)](https://cloudsmith.io/~consensys/repos/maven/packages/detail/maven/jc-kzg-4844/latest/a=noarch;xg=tech.pegasys/)
[![GitHub license](https://img.shields.io/github/license/ConsenSys/jc-kzg-4844.svg)](https://github.com/ConsenSys/jc-kzg-4844/blob/master/LICENSE)

Java wrapper around [C-KZG-4844](https://github.com/ethereum/c-kzg-4844)

⚠️ This project is still WIP.

## Dependency

```groovy
repositories {
    maven { url "https://artifacts.consensys.net/public/maven/maven/" }
}

dependencies {
    implementation("tech.pegasys:jc-kzg-4844:<version>")
}
```

## Minimal Sample

```java
// load once at startup
CKZG4844JNI.loadNativeLibrary(Preset.MAINNET);

// once loaded, all methods will use this trusted setup
CKZG4844JNI.loadTrustedSetup("trusted-setup.txt");

byte[]blob = ...;
byte[]commitment = CKZG4844JNI.blobToKzgCommitment(blob);
byte[]proof = CKZG4844JNI.computeAggregateKzgProof(blob,1);

boolean isValidProof = CKZG4844JNI.verifyAggregateKzgProof(blob,commitment,1,proof);

// this method should be called first if a different trusted setup needs to be loaded
CKZG4844JNI.freeTrustedSetup();
```

## Trusted Setup File Format

The trusted setup file which the library loads need to be of the following
format: [trusted_setup.txt](https://github.com/ethereum/c-kzg-4844/blob/main/src/trusted_setup.txt)

This could change with future versions of the library.

## Supported platforms

- x86-64
    - Windows
    - Linux
    - MacOS
- aarch64
    - Linux
    - MacOS