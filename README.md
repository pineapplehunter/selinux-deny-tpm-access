# SELinux Policy Module: my_trusted

A custom SELinux policy module that creates a trusted domain for TPM (Trusted Platform Module) access. This module extends the default targeted policy with rules for TPM device access.

## Prerequisites

Install the required packages:

```bash
sudo dnf install selinux-policy-devel policycoreutils make
```

Verify SELinux is enabled:

```bash
sestatus
```

## Building the Policy

Build the policy module to generate `my_trusted.pp`:

```bash
make
```

This uses the SELinux development infrastructure to compile the `.te`, `.fc`, and `.if` files into a policy package.

## Installing the Policy

Install the compiled policy module (also sets up file contexts automatically):

```bash
make install
```

This runs `semodule -i` and configures file context mappings for `/dev/tpm*` devices using `semanage fcontext`, then applies them with `restorecon`.

Or manually:

```bash
sudo semodule -i my_trusted.pp
sudo semanage fcontext -a -t my_tpm_device_t '/dev/tpm[0-9]*'
sudo semanage fcontext -a -t my_tpm_device_t '/dev/tpmrm[0-9]*'
sudo restorecon -rv /dev/tpm*
```

## Verifying Installation

Check that the module is loaded:

```bash
semodule -l | grep my_trusted
```

## Uninstalling

Remove the policy module:

```bash
make remove
```

Or manually:

```bash
sudo semodule -r my_trusted
```

## Policy Details

| File | Description |
|------|-------------|
| `my_trusted.te` | Type Enforcement rules defining `my_trusted_t` domain and TPM access |
| `my_trusted.fc` | File Context mappings for `/dev/tpm*` and `/dev/tpmrm*` devices |
| `my_trusted.if` | Interface definitions |

The module allows `unconfined_t` processes to transition to `my_trusted_t` domain when executing trusted executables, with access to TPM devices and terminal.
