defmodule ExTealDirectUpload.File do
  @moduledoc """
  A File field that references a
  single object on S3
  """
  use ExTeal.Field

  def component, do: "image-field"

  def options do
    bucket = Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket)
    presign_s3 = Application.get_env(:ex_teal_direct_upload, :presign_s3_urls)

    %{
      s3_host: "s3.amazonaws.com/#{bucket}",
      presign_s3: presign_s3,
      type: "file"
    }
  end

  def apply_options_for(
        %{options: %{presign_s3: true} = options, value: value} = field,
        _schema,
        _conn,
        _type
      )
      when not is_nil(value) do
    {:ok, url} = ExTealDirectUpload.signed_url_for(field.value)
    %{field | options: Map.put(options, :presigned_url, url)}
  end

  def apply_options_for(field, _schema, _conn, _type), do: field
end
