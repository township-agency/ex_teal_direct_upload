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

  defstruct file_name: nil, mimetype: nil, path: nil, acl: nil

  def date_util do
    Application.get_env(:ex_teal_direct_upload, :date_util, ExTealDirectUpload.DateUtil)
  end

  @doc """
  Generates a pre-signed URL for uploading a file to S3.

  This function takes an `Uploader` struct as an argument and returns a map containing the pre-signed URL, content type, URL, and path of the file to be uploaded.

  The pre-signed URL is generated using the `ExAws.S3.presigned_url/5` function with a default expiration time of 3600 seconds (1 hour). The `query_params` map is used to specify the AWS4-HMAC-SHA256 algorithm for signing the request.

  The returned map includes the following keys:

  - `presign_url`: The pre-signed URL for the upload.
  - `content_type`: The MIME type of the file being uploaded.
  - `url`: The full URL of the file in the S3 bucket.
  - `path`: The path of the file in the S3 bucket.

  This function is used to generate the necessary information for a client-side multipart POST to S3.
  """
  def presigned(%Uploader{} = upload) do
    query_params = %{
      "X-Amz-Algorithm" => "AWS4-HMAC-SHA256"
    }

    path = file_path(upload)

    {:ok, url} =
      :s3
      |> ExAws.Config.new([])
      |> ExAws.S3.presigned_url(:put, bucket(), path,
        expires_in: 3600,
        query_params: query_params
      )

    %{
      presign_url: url,
      content_type: upload.mimetype,
      url: "https://#{bucket()}.s3.amazonaws.com/#{path}",
      path: path
    }
  end

  @doc """

  Returns a json object with `url` and `credentials` properties.

  - `url` - the form action sURL
  - `credentials` - name/value pairs for hidden input fields

  """
  def presigned_json(%Uploader{} = upload) do
    upload
    |> presigned()
    |> Jason.encode!()
  end

  defp file_path(upload) do
    "#{upload.path}/#{upload.file_name}"
  end

  defp bucket, do: Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket)
end
