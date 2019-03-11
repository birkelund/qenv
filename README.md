# qenv

qenv is a small utility for rapidly getting up and running for doing emulated
nvme/ocssd device testing.

## Getting Started

Create the file `config`. Nothing is required in the file, but see the example
in `examples/config` if you want to modify any defaults.

### Generating a reference environment

If you do not have a base image to boot from, you can generate a reference Arch
Linux environment. Modifying `MIRROR` in `refenv/http/install.sh` will probably
speed up the process, so consider changing it to a mirror close to you.

To build the image go into the `refenv` directory and type `make`. The
resulting image is in `refenv/output-qemu/packer-qemu`. Copy it to
`img/base.img` (the default location of the base image).

### OpenChannel 2.0 emulation

See the documentation in the
[source](https://github.com/birkelund/qemu/blob/ocssd/v3/hw/block/nvme/ocssd.c)
for full instructions on how to configure the emulated device.

Create a zero-sized backing image:

    qemu-img create -f raw img/ocssd.img 0

### Running

Run with the ocssd device, an emulated iommu and debugging enabled:

    ./run --ocssd --enable-iommu --debug

Or with a custom kernel image:

    ./run --ocssd --enable-iommu --debug --kernel bzImage

### Connecting

Connect to the running VM using:

    ./ssh
