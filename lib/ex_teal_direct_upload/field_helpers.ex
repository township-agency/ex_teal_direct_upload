defmodule ExTealDirectUpload.FieldHelpers do
  @moduledoc """
  Shared options functionality for fields
  """

  def options do
    bucket = Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket)
    region = Application.get_env(:ex_teal_direct_upload, :aws_region)
    imgix = Application.get_env(:ex_teal_direct_upload, :imgix_source)
    presign_s3_urls = Application.get_env(:ex_teal_direct_upload, :presign_s3_urls)

    height = "64"
    width = "64"

    %{
      imgix_host: imgix,
      s3_host: "s3.#{region}.amazonaws.com/#{bucket}",
      type: "imgix",
      height: height,
      width: width,
      presign_s3_urls: presign_s3_urls
    }
  end
end
