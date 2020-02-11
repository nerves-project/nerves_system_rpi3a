# Changelog

## v1.10.2

* Fixes
  * This fixes a regression on OSX where the USB gadget Ethernet would
    incorrectly try to go into RNDIS mode and not work. Gadget Ethernet works
    with this fix on Linux and OSX. It also works on Windows with a driver
    installed.

* Updated dependencies
  * [nerves_system_br v1.10.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.10.2)
  * Erlang 22.2.4

## v1.10.1

This release changes the behavior of the gadget port as well as the UART pins
on the GPIO header. The gadget driver has been changed to use g_ether. This
provides a more stable network connection at the expense of the virtual serial
port. Console access has been output to the UART. If you were using the UART
to connect to peripherals, you will need to disable the console.
See: https://hexdocs.pm/nerves/advanced-configuration.html#overwriting-files-in-the-boot-partition
for more information.

* Enhancements
  * Set `expand=true` on the application data partition. This will only take
    effect for users running the complete task, fwup will not expand application
    data partitions that exist during upgrade tasks.
  * linux: swap the cdc composite gadget for g_ether

* Updated dependencies
  * [nerves_system_br v1.10.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.10.1)
  * Erlang 22.2.3


## v1.10.0

This release updates Buildroot to 2019.11 with security and bug fix updates
across Linux packages. Enables dnsd, udhcpd and ifconfig in the default
Busybox configuration to support `vintage_net` and `vintage_net_wizard`.
See the `nerves_system_br` notes for details.

* Updated dependencies
  * [nerves_system_br v1.10.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.10.0)
  * Erlang 22.1.8

## v1.9.2

This release updates Buildroot to 2019.08.2 with security and bug fix updates
across Linux packages. See the `nerves_system_br` notes for details.
Erlang/OTP is now at 22.1.7.

* Updated dependencies
  * [nerves_system_br v1.9.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.9.5)

## v1.9.1

This release pulls in security and bug fix updates from `nerves_system_br`.
Erlang/OTP is now at 22.1.1.

* Bug fixes
  * This system should work out of the box now with Scenic and the offical RPi
    Touchscreen display. The issue preventing it from working has been fixed.

* Updated dependencies
  * [nerves_system_br v1.9.4](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.9.4)
  * linux - update to the raspberrypi-kernel_1.20190925-1 tag

## v1.9.0

This release updates Buildroot to 2019.08 with security and bug fix updates
across Linux packages. See the `nerves_system_br` notes for details.

* Updated dependencies
  * [nerves_system_br v1.9.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.9.2)

## v1.8.2

This release fixes an issue that broke display output on small LCD screens.
Updating the Raspberry Pi firmware to the latest from the Raspberry Pi
Foundation fixed the issue. See
https://github.com/fhunleth/rpi_fb_capture/issues/2 for details.

* Updated dependencies
  * [nerves_system_br v1.8.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.8.5)

## v1.8.1

* Updated dependencies
  * [nerves_system_br v1.8.4](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.8.4)
  * Linux 4.19.58 with patches from the Raspberry Pi Foundation

## v1.8.0

This release

This release updates Erlang to OTP 22 and gcc from version 7.3.0 to 8.3.0.
See the nerves_system_br and toolchain release notes for more information.

* Enhancements
  * Enable source-based routing in the Linux kernel to support [vintage_net](https://github.com/nerves-networking/vintage_net)

* Updated dependencies
  * Erlang 22.0.4
  * [nerves_system_br v1.8.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.8.2)
  * [nerves_toolchain_arm_unknown_linux_gnueabihf v1.2.0](https://github.com/nerves-project/toolchains/releases/tag/v1.2.0)

## v1.7.2

* Bux fixes
  * Add TAR option `--no-same-owner` to fix errors when untarring artifacts as
    the root user.
* Updated dependencies
  * [nerves_system_br v1.7.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.7.2)

## v1.7.1

This release fixes a major issue with the gadget USB port where it would hang on
boot. If you have made a custom system or are overriding the `erlinit.config`
file in your project, please make sure that your `erlinit.config` has:

```text
-c null
-s "/usr/bin/nbtty --tty /dev/ttyGS0 --wait-input"
```

* Bug fixes
  * Fix regression with virtual serial port where it could cause the whole USB
    interface to hang.

* Improvements
  * Bump C compiler options to `-O2` from `-Os`. This provides a small, but
    measurable performance improvement (500ms at boot in a trivial RPi0 project).

* Updated dependencies
  * [nerves_system_br v1.7.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.7.1)

## v1.7.0

This release bumps the Linux kernel to 4.19.25. This change had an impact on how
the WiFi regulatory database gets loaded into the kernel. Instead of building it
into the kernel as previously done, the kernel loads it on demand. This requires
that all WiFi drivers be built as kernel modules so that the database isn't
loaded before the root filesystem is mounted. If you made a custom system and
see boot errors about not being able to load the regulatory database, this is
the problem.

A known bug with the Raspberry Pi Zero USB gadget interface is that it sometimes
doesn't load on Linux systems. Moving the gadget drivers to kernel modules seems
to work around this but it takes longer to load the gadget interface.

* Updated dependencies
  * [nerves_system_br v1.7.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.7.0)
  * Linux 4.19.25 with patches from the Raspberry Pi Foundation

## v1.6.3

 * Updated dependencies
  * [nerves_system_br v1.6.8](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.8)
  * Erlang 21.2.6

## v1.6.2

* Updated dependencies
  * [nerves_system_br v1.6.6](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.6)
  * Erlang 21.2.4
  * boardid 1.5.3

## v1.6.1

* Updated dependencies
  * [nerves_system_br v1.6.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.5)
  * Erlang 21.2.2
  * boardid 1.5.2
  * erlinit 1.4.9
  * OpenSSL 1.1.1a
  * Linux 4.14.89 with patches from the Raspberry Pi Foundation

* Enhancements
  * Moved boardid config from inside erlinit.config to /etc/boardid.config
  * Compile gpiomem into the Linux kernel
  * Enable pstore, an in-memory buffer that can capture logs, kernel
    oops and other information when unexpected reboots. The buffer can be
    recovered on the next boot where it can be inspected.

## v1.6.0 and before

See
[nerves_system_rpi3/CHANGELOG.md](https://github.com/nerves-project/nerves_system_rpi3/blob/master/CHANGELOG.md) for
history before this was forked off of `nerves_system_rpi3`

