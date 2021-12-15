# Raspberry Pi Bazel Cross-Compilation Template

This project is a fork of Josh Pieper's ["Raspberry Pi bazel cross-compilation rules" rpi_bazel](https://github.com/mjbots/rpi_bazel) repo. The reasons to part ways from his effort were multiple:

* The original repo covered Linux as a host platform exclusively. I wanted to invite macOS to join the discussion. That way, devs have freedom of choice.

* I also wanted to apply different versions of Bazel as soon as they're available.

* Likewise, different versions of Clang as a toolchain, as new ones get released.

* And, last but not least, different Raspberry Pi `sysroot` as I could get it updated.

This repo, however, is a template that I pull from automated processes and produce two outcomes: a compressed bundle for macOS and another for Linux.

Feel free to visit my [Releases page](https://github.com/diegum/rpi_bazel/releases/latest) and download a version that fulfills your needs. Cloning this template repo would be of little to no use for you.
