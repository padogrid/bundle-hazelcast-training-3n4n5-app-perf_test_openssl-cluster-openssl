![PadoGrid](https://github.com/padogrid/padogrid/raw/develop/images/padogrid-3d-16x16.png) [*PadoGrid*](https://github.com/padogrid) | [*Catalogs*](https://github.com/padogrid/catalog-bundles/blob/master/all-catalog.md) | [*Manual*](https://github.com/padogrid/padogrid/wiki) | [*FAQ*](https://github.com/padogrid/padogrid/wiki/faq) | [*Releases*](https://github.com/padogrid/padogrid/releases) | [*Templates*](https://github.com/padogrid/padogrid/wiki/Using-Bundle-Templates) | [*Pods*](https://github.com/padogrid/padogrid/wiki/Understanding-Padogrid-Pods) | [*Kubernetes*](https://github.com/padogrid/padogrid/wiki/Kubernetes) | [*Docker*](https://github.com/padogrid/padogrid/wiki/Docker) | [*Apps*](https://github.com/padogrid/padogrid/wiki/Apps) | [*Quick Start*](https://github.com/padogrid/padogrid/wiki/Quick-Start)

---

<!-- Platforms -->
[![PadoGrid 1.x](https://github.com/padogrid/padogrid/wiki/images/padogrid-padogrid-1.x.drawio.svg)](https://github.com/padogrid/padogrid/wiki/Platform-PadoGrid-1.x) [![Host OS](https://github.com/padogrid/padogrid/wiki/images/padogrid-host-os.drawio.svg)](https://github.com/padogrid/padogrid/wiki/Platform-Host-OS) [![VM](https://github.com/padogrid/padogrid/wiki/images/padogrid-vm.drawio.svg)](https://github.com/padogrid/padogrid/wiki/Platform-VM) [![Docker](https://github.com/padogrid/padogrid/wiki/images/padogrid-docker.drawio.svg)](https://github.com/padogrid/padogrid/wiki/Platform-Docker) [![Kubernetes](https://github.com/padogrid/padogrid/wiki/images/padogrid-kubernetes.drawio.svg)](https://github.com/padogrid/padogrid/wiki/Platform-Kubernetes)

# IMDG Cluster: openssl

As part of the TLS/SSL lab of Hazelcast Operations Training, this bundle includes the `openssl` cluster preconfigured to enable OpenSSL/BoringSSL.

## Installing Bundle

```bash
install_bundle -download bundle-hazelcast-training-3n4n5-app-perf_test_openssl-cluster-openssl
```

## Use Case

*This bundle is for training use only.* As part of the OpenSSL lab, this bundles includes a cluster and an app configured with a private key and a trusted certificate.

![OpenSSL Cluster Diagram](images/openssl-cluster.jpg)

## Private Key and Trusted Certificate

This distribution contains the following self-signed 4096-bit private key and trusted certificate files expiring on May 26, 2030.

```bash
switch_cluster openssl
tree etc/ssl
```

```console
etc/ssl
├── lab.crt
└── lab.key
```

They are created by executing the following `openssl` command.

```bash
openssl req -newkey rsa:4096 -x509 -sha256 -days 3650 -nodes -out lab.crt -keyout lab.key -subj "/CN=*.demo.com"
```

To check the certificate content, execute the following.

```bash
openssl x509 -in etc/ssl/lab.crt -text
```
:pencil2: OpenSSL may not work on macOS.

:pencil2: Hazelcast Mangement Center only supports OpenSSL as a client to Hazelcast clusters and does not support OpenSSL for the browser. You must configure Java TLS/SSL for the brower to enable HTTPS. This bundle runs the Management Center with HTTP. For configuring HTTPS, see the following bundle.

https://github.com/padogrid/bundle-hazelcast-training-3n4n5-app-perf_test_ssl-cluster-ssl

## 1. Add Host Names

The certficate is created for the domain name `demo.com` and hence you must set the domain name for your machine. This is done by defining host names with the domain name in the `/etc/hosts` file, which requires root acccess.


```bash
sudo vi /etc/hosts
```

```dos
notepad %windir%\system32\drivers\etc\hosts
```

Add the following line with `server1`, `server2`, and `server3` as host names for the three (3) cluster members.

```bash
# Example. Replace the IP address with your machine's IP address and "mymachine" to your machine's host name.
192.168.1.6 mymachine server1.demo.com server2.demo.com server3.demo.com
```

## 2. Initialize Environment

First, intialize your bundle environment to your workspace's Hazelcast version. The followin scripts places the correct configuration files to their respective `etc/` directories.

```bash
# Initialize client
cd_app perf_test_openssl; cd bin_sh
./init_app

# Intialize cluster
switch_cluster openssl; cd bin_sh
./init_cluster
```

## 3. Build `openssl` Cluster

If the bundle does not include openssl binaries in the lib directory then you must run the `build_app` script to download the binaries.

```bash
switch_cluster openssl; cd bin_sh
./build_app
```

## 4. Start `openssl` Cluster

```bash
# Add members. Bundles do not include members.
add_member; add_member

# Start cluster
start_cluster

# See SSL messages in the log file
show_log
```

## 5. Start Client

```bash
cd_app perf_test_openssl; cd bin_sh

# To ingest data (ingest data into the 'eligibility' and 'profile' maps)
./test_ingestion -run

# To read ingested data
./read_cache eligibility
./read_cache profile
```

The SSL debug is enabled for the `perf_test_openssl` app, i.e., `-Djavax.net.debug=SSL` (see `setenv.sh`). You should see SSL debug outputs in the shell console.

## Teardown

```bash
stop_cluster
```

## References

1. Bundle: Hazelcast *IMDG Cluster: ssl*, <https://github.com/padogrid/bundle-hazelcast-training-3n4n5-app-perf_test_ssl-cluster-ssl>

---

![PadoGrid](https://github.com/padogrid/padogrid/raw/develop/images/padogrid-3d-16x16.png) [*PadoGrid*](https://github.com/padogrid) | [*Catalogs*](https://github.com/padogrid/catalog-bundles/blob/master/all-catalog.md) | [*Manual*](https://github.com/padogrid/padogrid/wiki) | [*FAQ*](https://github.com/padogrid/padogrid/wiki/faq) | [*Releases*](https://github.com/padogrid/padogrid/releases) | [*Templates*](https://github.com/padogrid/padogrid/wiki/Using-Bundle-Templates) | [*Pods*](https://github.com/padogrid/padogrid/wiki/Understanding-Padogrid-Pods) | [*Kubernetes*](https://github.com/padogrid/padogrid/wiki/Kubernetes) | [*Docker*](https://github.com/padogrid/padogrid/wiki/Docker) | [*Apps*](https://github.com/padogrid/padogrid/wiki/Apps) | [*Quick Start*](https://github.com/padogrid/padogrid/wiki/Quick-Start)
