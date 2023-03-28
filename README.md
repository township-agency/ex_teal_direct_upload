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
  aws_access_key: System.get_env("AWS_ACCESS_KEY_ID"),
  aws_secret_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  aws_s3_bucket: System.get_env("AWS_S3_BUCKET"),
  aws_region: System.get_env("AWS_REGION") || "us-east-1",
  imgix_source: System.get_env("IMGIX_SOURCE") # optional
```

and add it to your list of plugins in the `ex_teal` manifest:

```elixir
def plugins,
  do: [
    ExTealDirectUpload.Plugin.new(%{})
  ]
```

## Using Direct Upload

This plugin exposes several new field types:

* `ExTealDirectUpload.Image` persists the key of an image to a string and can handle proxying fetch requests of the image through an imgix source
* `ExTealDirectUpload.ImageArray` persists a list of images to an `string[]` array and can handle fetch requests through an imgix source
* `ExTealDirectUpload.File` persists a file key to a string and stores the file on S3.

Originally this plugin was completely dependent on a single architecture that included reading from a Imgix source and direct S3 uploads.
This has been refactored to be more consistent across our projects to allow an _optional_ imgix source