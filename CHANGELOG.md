# Changelog

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

