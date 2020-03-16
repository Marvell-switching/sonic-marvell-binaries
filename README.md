-# sonic-marvell-binaries
-Sonic binaries for Marvell Platform


.
|-- amd64
|   `-- sai-plugin                              x86_64-marvell_db98cx8580_16cd-r0/ x86_64-marvell_db98cx8580_32cd-r0/
|       |-- mrvllibsai_amd64_1.4.1.deb
|       |-- mrvllibsai_amd64_1.5.1.deb
|       `-- mrvllibsai_dbg_amd64_1.5.1.deb
|-- arm64                                       arm64-marvell_db98cx8580_16cd-r0/ arm64-marvell_db98cx8580_32cd-r0/
|   |-- kernel
|   |   |-- build_debian_package.sh
|   |   |-- eeprom
|   |   |-- ent.py
|   |   |-- linux-image-4.4-arm64.deb
|   |   |-- linux-image-4.4.120-arm64.deb
|   |   `-- linux-image-4.9.168-arm64.deb
|   `-- sai-plugin
|       |-- mrvllibsai_arm64_1.4.1.deb
|       |-- mrvllibsai_arm64_1.5.1.deb
|       `-- mrvllibsai_dbg_arm64_1.5.1.deb
|-- armhf                                       armhf-marvell_et6448m_52x-r0/
|   |-- kernel
|   |   |-- linux-image-4.4.8_4.4.8-4_armhf.deb
|   |   `-- linux-image-4.9.168-armhf.deb
|   `-- sai-plugin
|       |-- mrvllibsai_armhf_1.4.1.deb
|       |-- mrvllibsai_armhf_1.4.1.deb_Aug_6
|       `-- mrvllibsai_armhf_1.5.1.deb
`-- scripts
    |-- build_debian_package.sh
    |-- build_kernel_debian_arm64.sh
    `-- build_kernel_debian_armhf.sh

