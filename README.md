# ExTealDirectUpload

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `teal_imgix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_teal_direct_upload, "~> 0.8", organization: "motel"}
  ]
end
```

Configure `ex_teal_direct_upload`:

```elixir
config :ex_teal_direct_upload,
  aws_s3_bucket: System.get_env("AWS_S3_BUCKET"),
  aws_region: System.get_env("AWS_REGION") || "us-east-1",
  imgix_source: System.get_env("IMGIX_SOURCE"), # optional
  aws_role_arn: System.get_env("AWS_ROLE_ARN"), # only include if using aws sts
```

and add it to your list of plugins in the `ex_teal` manifest:

```elixir
def plugins,
  do: [
    ExTealDirectUpload.Plugin.new(%{})
  ]
```

Direct Upload delegates responsibilities for generating presigned urls to the `ex_aws` and `ex_aws_s3` libraries.  Ensure that `ExAws` is configured
correctly.

## Using temporary role assignment with AWS STS

To use AWS STS, add the `aws_role_arn` to your application's config for
ex_teal_direct_upload.

```elixir
config :ex_teal_direct_upload,
  aws_s3_bucket: System.get_env("AWS_S3_BUCKET"),
  aws_region: System.get_env("AWS_REGION") || "us-east-1",
  aws_role_arn: System.get_env("AWS_ROLE_ARN"), # only include if using aws sts
```

Additionally, be sure to  include `ex_aws_sts` in your list of dependencies.

```elixir
def deps do
  [
    {:ex_teal_direct_upload, "~> 0.8", organization: "motel"},
    {:ex_aws_sts, "~> 2.2"}
  ]
end
```

## Using Direct Upload

This plugin exposes several new field types:

* `ExTealDirectUpload.Image` persists the key of an image to a string and can handle proxying fetch requests of the image through an imgix source
* `ExTealDirectUpload.ImageArray` persists a list of images to an `string[]` array and can handle fetch requests through an imgix source
* `ExTealDirectUpload.File` persists a file key to a string and stores the file on S3.

Originally this plugin was completely dependent on a single architecture that included reading from a Imgix source and direct S3 uploads.
This has been refactored to be more consistent across our projects to allow an _optional_ imgix source
