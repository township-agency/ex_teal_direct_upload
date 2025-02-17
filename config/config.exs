# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
import Config

config :ex_aws, json_codec: Jason

config :ex_teal_direct_upload,
  aws_s3_bucket: System.get_env("AWS_S3_BUCKET"),
  aws_region: System.get_env("AWS_REGION") || "us-east-1",
  imgix_source: System.get_env("IMGIX_SOURCE"),
  aws_acl: "public-read",
  presign_s3_urls: false,
  presign_interval: 3600,
  use_aws_sts: false

if Mix.env() == :test do
  import_config "#{Mix.env()}.exs"
end
