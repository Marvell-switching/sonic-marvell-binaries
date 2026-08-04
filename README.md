# sonic-marvell-binaries

[![Marvell Technologies](https://www.marvell.com/content/dam/marvell/en/rebrand/marvell-logo3.svg)](https://www.marvell.com/)


## Sonic binaries for Marvell Platform

This repo is used by the SONiC build with only the **master** git branch checked out.

Each architecture **`<arch>/sai-plugin/master/`** contains a flat pool of every `mrvllibsai_*_<arch>.deb` Marvell has released, regardless of SONiC branch.
Paths such as **`<arch>/sai-plugin/202505/`** (and other per-SONiC-branch names in the tree below) hold copies from the matching `master/`
directory of only the DEBs needed for that branch.

Which package is used by a given SONiC branch~build is chosen in `sonic-buildimage/platform/marvell-prestera/sai.mk`,
which points at this repo on **master**.

Different SONiC branches may pin different `mrvllibsai` versions; those packages still live in the same per-arch `.../sai-plugin/master/` pools.

```sh
.
|-- arm64/kernel (legacy, not used since 2024)
|-- armhf/kernel (legacy, not used since 2024)
|-- scripts      (legacy, not used since 2024)
|
|       "Flat-Pool" of ALL released DEBs
|-- amd64/sai-plugin/master/
|           -- mrvllibsai_1.17.1-13_amd64.deb
|           -- mrvllibsai_1.18.1-1_amd64.deb
|
|-- arm64/sai-plugin/master/
|           -- mrvllibsai_1.17.1-13_arm64.deb
|           -- mrvllibsai_1.18.1-1_arm64.deb
|
|-- armhf/sai-plugin/master/
|           -- mrvllibsai_1.17.1-13_armhf.deb
|           -- mrvllibsai_1.18.1-1_armhf.deb
|
|                    DIRECTORIES containing released mrvllibsai*.deb
|-- amd64/sai-plugin/202505/   COPY from master directory only relevant for a SONiC branch
|-- arm64/sai-plugin/202505/   ...
|-- armhf/sai-plugin/202505/   ...
|
|-- amd64/sai-plugin/202511/   ...
|-- arm64/sai-plugin/202511/   ...
|-- armhf/sai-plugin/202511/   ...
|
|-- amd64/sai-plugin/202605/   ...
|-- arm64/sai-plugin/202605/   ...
|-- armhf/sai-plugin/202605/   ...
```
