defmodule ExTealDirectUpload do
  @moduledoc false

  def signed_url_for(object_path) do
    config = ExAws.Config.new(:s3, [])
    ExAws.S3.presigned_url(config, :get, bucket(), object_path, expires_in: expires_in())
  end

  defp expires_in, do: Application.get_env(:ex_teal_direct_upload, :presign_interval, 3600)
  defp bucket, do: Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket)
end
