use Mix.Config

# Test configuration
config :ex_teal_direct_upload,
  aws_access_key: "123abc",
  aws_secret_key: "abc123",
  aws_s3_bucket: "s3-bucket",
  imgix_bucket: "imgix-proxy.imgix.net",
  date_util: ExTealDirectUpload.StaticDateUtil

config :phoenix, :json_library, Jason
