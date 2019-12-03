defmodule ExTealDirectUpload.UploaderTest do
  use ExUnit.Case
  doctest ExTealDirectUpload.Uploader
  alias ExTealDirectUpload.Uploader

  import Map, only: [get: 2]

  test "presigned_json" do
    upload = %Uploader{
      file_name: "file.jpg",
      mimetype: "image/jpeg",
      path: "path/in/bucket",
      acl: "public-read"
    }

    result = upload |> Uploader.presigned_json() |> Jason.decode!()
    assert result |> get("postEndpoint") == "https://s3-bucket.s3.amazonaws.com"
    credentials = result |> get("signature")
    assert credentials |> get("acl") == "public-read"
    assert credentials |> get("key") == "path/in/bucket/file.jpg"
    assert credentials |> get("policy") |> String.slice(0..9) == "eyJjb25kaX"
    assert credentials |> get("X-amz-algorithm") == "AWS4-HMAC-SHA256"
    assert credentials |> get("X-amz-credential") == "123abc/20170101/us-east-1/s3/aws4_request"
    assert credentials |> get("X-amz-date") == "20170101T000000Z"

    assert credentials |> get("X-amz-signature") ==
             "86279d957efa0f11c95ddcc0c40f060fa818cad230bd45aacf5ac1c055226613"
  end
end
