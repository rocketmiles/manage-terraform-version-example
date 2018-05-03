# Managed Terraform Versions

This is an example repo to this [blog post]().

The usage below assumes you have the AWS environment variables or the `.aws/credentials` setup.

## Usage

```
make init
```

```
make plan
```

```
make apply
```

## Changing Terraform Version

Modify the `TERRAFORM_VERSION` variable to a valid terraform version and when you run `make tf-version` it will download that version and replace the one you have currently.

You can check the version of the binary with:

```
.tf/terraform version
```

That should display the terraform binary version message.