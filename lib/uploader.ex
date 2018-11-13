defmodule ExTealDirectUpload.Uploader do
  alias ExTealDirectUpload.Uploader

  @moduledoc """

  Pre-signed S3 upload helper for client-side multipart POSTs.

  See:

  [Browser-Based Upload using HTTP POST (Using AWS Signature Version 4)](http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-post-example.html)

  [Task 3: Calculate the Signature for AWS Signature Version 4](http://docs.aws.amazon.com/general/latest/gr/sigv4-calculate-signature.html)

  This module expects three application configuration settings for the
  AWS access and secret keys and the S3 bucket name. You may also
  supply an AWS region (the default if you do not is
  `us-east-1`). Here is an example configuration that reads these from
  environment variables. Add your own configuration to `config.exs`.

  ```
  config :ex_teal_direct_upload,
    aws_access_key: System.get_env("AWS_ACCESS_KEY_ID"),
    aws_secret_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
    aws_s3_bucket: System.get_env("AWS_S3_BUCKET"),
    aws_region: System.get_env("AWS_REGION")
  ```

  """

  @doc """

  The `Uploader` struct represents the data necessary to
  generate an S3 pre-signed upload object.

  The required fields are:

  - `file_name` the name of the file being uploaded
  - `mimetype` the mimetype of the file being uploaded
  - `path` the path where the file will be uploaded in the bucket

  Fields that can be over-ridden are:

  - `acl` defaults to `public-read`

  """
  defstruct file_name: nil, mimetype: nil, path: nil, acl: "public-read"

  @date_util Application.get_env(:ex_teal_direct_upload, :date_util, ExTealDirectUpload.DateUtil)

  @doc """

  Returns a map with `url` and `credentials` keys.

  - `url` - the form action URL
  - `credentials` - name/value pairs for hidden input fields

  ## Examples

      iex> %ExTealDirectUpload.Uploader{file_name: "image.jpg", mimetype: "image/jpeg", path: "path/to/file"}
      ...> |> ExTealDirectUpload.Uploader.presigned
      ...> |> Map.get(:postEndpoint)
      "https://s3-bucket.s3.amazonaws.com"

      iex> %ExTealDirectUpload.Uploader{file_name: "image.jpg", mimetype: "image/jpeg", path: "path/to/file"}
      ...> |> ExTealDirectUpload.Uploader.presigned
      ...> |> Map.get(:signature) |> Map.get(:"X-amz-credential")
      "123abc/20170101/us-east-1/s3/aws4_request"

      iex> %ExTealDirectUpload.Uploader{file_name: "image.jpg", mimetype: "image/jpeg", path: "path/to/file"}
      ...> |> ExTealDirectUpload.Uploader.presigned
      ...> |> Map.get(:signature) |> Map.get(:key)
      "path/to/file/image.jpg"

  """
  def presigned(%Uploader{} = upload) do
    %{
      postEndpoint: "https://#{bucket()}.s3.amazonaws.com",
      signature: %{
        "Content-Type": upload.mimetype,
        policy: policy(upload),
        "X-amz-algorithm": "AWS4-HMAC-SHA256",
        "X-amz-credential": credential(),
        "X-amz-date": @date_util.today_datetime(),
        "X-amz-signature": signature(upload),
        acl: upload.acl,
        key: file_path(upload),
        success_action_status: "201"
      }
    }
  end

  @doc """

  Returns a json object with `url` and `credentials` properties.

  - `url` - the form action URL
  - `credentials` - name/value pairs for hidden input fields

  """
  def presigned_json(%Uploader{} = upload) do
    upload
    |> presigned()
    |> Jason.encode!()
  end

  defp signature(upload) do
    signing_key()
    |> hmac(policy(upload))
    |> Base.encode16(case: :lower)
  end

  defp signing_key do
    "AWS4#{secret_key()}"
    |> hmac(@date_util.today_date())
    |> hmac(region())
    |> hmac("s3")
    |> hmac("aws4_request")
  end

  defp policy(upload) do
    %{
      expiration: @date_util.expiration_datetime,
      conditions: conditions(upload)
    }
    |> Jason.encode!()
    |> Base.encode64()
  end

  defp conditions(upload) do
    [
      %{"bucket" => bucket()},
      %{"acl" => upload.acl},
      %{"x-amz-algorithm": "AWS4-HMAC-SHA256"},
      %{"x-amz-credential": credential()},
      %{"x-amz-date": @date_util.today_datetime()},
      ["starts-with", "$Content-Type", upload.mimetype],
      ["starts-with", "$key", upload.path],
      %{"success_action_status" => "201"}
    ]
  end

  defp credential do
    "#{access_key()}/#{@date_util.today_date()}/#{region()}/s3/aws4_request"
  end

  defp file_path(upload) do
    "#{upload.path}/#{upload.file_name}"
  end

  defp hmac(key, data) do
    :crypto.hmac(:sha256, key, data)
  end

  defp access_key, do: Application.get_env(:ex_teal_direct_upload, :aws_access_key)
  defp secret_key, do: Application.get_env(:ex_teal_direct_upload, :aws_secret_key)
  defp bucket, do: Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket)
  defp region, do: Application.get_env(:ex_teal_direct_upload, :aws_region) || "us-east-1"
end
