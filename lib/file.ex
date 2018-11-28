defmodule ExTealDirectUpload.File do
  @moduledoc """
  A File field that references a
  single object on S3
  """
  use ExTeal.Field

  def component, do: "file-field"

  def options do
    bucket = Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket)

    %{
      s3_host: "s3.amazonaws.com/#{bucket}",
      type: "file"
    }
  end
end
