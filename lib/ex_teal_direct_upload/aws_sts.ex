defmodule ExTealDirectUpload.AwsSts do
  @moduledoc """
  Module for handling AWS STS
  for temporary assignment of roles to upload users
  """

  @session_name "ex_teal_direct_upload"
  @credentials_duration 3_600

  def config do
    case assume_role() do
      {:ok, %{body: credentials}} ->
        ExAws.Config.new(:s3,
          access_key_id: credentials.access_key_id,
          secret_access_key: credentials.secret_access_key,
          security_token: credentials.session_token,
          region: region()
        )

      _ ->
        {:error, :invalid_role_request}
    end
  end

  def enabled? do
    case role_arn() do
      nil -> false
      "" -> false
      _ -> true
    end
  end

  defp assume_role,
    do:
      role_arn()
      |> ExAws.STS.assume_role(@session_name, duration: @credentials_duration)
      |> ExAws.request()

  defp region, do: Application.get_env(:ex_teal_direct_upload, :aws_region)
  defp role_arn, do: Application.get_env(:ex_teal_direct_upload, :aws_role_arn)
end
