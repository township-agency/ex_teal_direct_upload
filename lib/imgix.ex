defmodule ExTealDirectUpload.Imgix do
  @moduledoc """
  A file form component that uses imgix as
  a proxy for fetching the asset
  """
  use ExTeal.Field

  def component, do: "imgix-field"

  def default_sortable, do: false

  def options do
    bucket = Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket)
    region = Application.get_env(:ex_teal_direct_upload, :aws_region)
    imgix = Application.get_env(:ex_teal_direct_upload, :imgix_source)
    height = "64"
    width = "64"

    %{
      imgix_host: imgix,
      s3_host: "s3.#{region}.amazonaws.com/#{bucket}",
      type: "imgix",
      height: height,
      width: width
    }
  end

  def custom_width_and_height(%Field{options: options} = field, width, height) do
    opts = Map.merge(options, %{width: width, height: height})
    %{field | options: opts}
  end
end
