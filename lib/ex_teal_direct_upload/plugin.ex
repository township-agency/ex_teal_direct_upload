defmodule ExTealDirectUpload.Plugin do
  @moduledoc false

  use ExTeal.Plugin

  alias ExTeal.Asset.Script

  def repo, do: nil

  def router, do: ExTealDirectUpload.Router

  def uri, do: "direct-upload"

  def scripts, do: [%Script{path: "js/field.js"}]

  def js_config, do: %{
    imgix_source: Application.get_env(:ex_teal_direct_upload, :imgix_source),
    aws_s3_bucket: Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket),
  }
end
