# Overview

`serp` is a simple command line tool to help with creation of (se)cure (r)edundant (p)ackages.

It can package a directory full of files into encrypted and compressed archive file,
while also producing checksum and parity (data redundancy) information
that can be used to detect data corruption and repair the file.

`serp` also provides a convenient way to extract such archive into a directory.

## Example

Let's say there is a directory `~/taxes` full of files with some very sensitive information.

To create an archive with `serp` run:

```
serp -p ~/taxes
```

This will create the following files in the current working directory:

- `taxes.tar.gpg` - encrypted archive of the `~/taxes` directory.
- `taxes.tar.gpg.sha1` - SHA1 checksum of the `taxes.tar.gpg` file.
- `taxes.par.gpg.par2` and `taxes.par.gpg.vol00+XX.par2` (where `XX` is some number) -
files with parity information that can be used to restore `taxes.tar.gpg`.

To extract `taxes.tar.gpg` into new `~/extracted_taxes` directory run:

```
serp -u ~/extracted_taxes -n taxes
```

This will first check SHA1 sum of the `taxes.tar.gpg` and if its correct - extract the files.
If not, `serp` will print instructions on how to repair `taxes.tar.gpg` with PAR2 utility.


## Rationale

Encryption is essential for storing files containing sensitive information.
However, encrypted files are very difficult (if not impossible) to restore in case of data corruption
that may happen during long term storage (bit rot) or storage on unreliable media.

Backups won't protect against this scenario, as corrupted data will be backed up and thus
original data could be eventually lost (unless there are backups available prior to data corruption).

One way to solve this issue is to produce parity information that can be used to
repair the files in case of data corruption.

## Implementation

`serp` is implemented as a POSIX compliant shell script that provides simple interface to
pack/unpack data to/from encrypted archive with parity information.

`serp` doesn't really have any logic on its own and is merely a convenient wrapper around the following tools:

- `TAR`: used to package contents of a given directory into a single file.
- `GPG`: used to encrypt and compress tar file.
- `sha1sum`: used to calculate and verify SHA1 sum of the encrypted archive.
- `PAR2`: used to generate parity information for the encrypted archive.

### Compression

The default GPG compression is applied, which is ZIP at compression level 6.

### Encryption

Archive is symmetrically encrypted using AES256 algorithm.
You will be prompted for a password for encryption/decryption.

# Installation

Download latest release, extract and run:

```
make install
```

To uninstall, run:

```
make uninstall
```

## Dependencies

The following dependencies needs to be installed manually: `TAR`, `GPG`, `sha1sum` and `PAR2`.

### Debian and Ubuntu

Run:

```
sudo apt install coreutils tar gpg par2
```

### Archlinux

Run:

```
sudo pacman -S coreutils tar gnupg par2cmdline
```

### CentOS, Fedora, RHEL

Run:

```
sudo yum install coreutils tar gnupg par2cmdline
```

# Usage

After installation run `man 1 serp` for the full manual.

Alternatively, run `serp -h`.

# License

MIT License (see LICENSE file).

The software is provided "AS IS", WITHOUT WARRANTY of any kind.
Authors and contributors of the software are not responsible in any way for any data corruption or loss that may occur.

