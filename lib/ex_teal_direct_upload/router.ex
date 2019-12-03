defmodule ExTealDirectUpload.Router do
  @moduledoc """
  Routing for ExTeal Direct Upload
  """
  use Plug.Router

  alias ExTealDirectUpload.Uploader
  alias Plug.Conn

  plug(Plug.Static,
    at: "/",
    from: {:ex_teal_direct_upload, "priv/static"}
  )

  plug(Plug.Logger, log: :debug)

  plug(Plug.Parsers, parsers: [:urlencoded])
  plug(Plug.MethodOverride)

  plug(:match)
  plug(:dispatch)

  def init, do: []

  @doc false
  def call(conn, opts) do
    conn =
      conn
      |> extract_namespace(opts)
      |> Conn.put_private(:plug_skip_csrf_protection, true)

    super(conn, opts)
  end

  post "/sign" do
    file_name = conn.params["fileName"]
    mimetype = conn.params["contentType"]
    uniq_key = random_string(10)

    upload = %Uploader{
      file_name: file_name |> String.replace(~r/\s/, "-"),
      mimetype: mimetype,
      path: conn.params["path"] || "uploads/#{uniq_key}",
      acl: acl()
    }

    send_resp(conn, 200, Uploader.presigned_json(upload))
  end

  defp acl, do: Application.get_env(:ex_teal_direct_upload, :aws_acl, "public-read")

  defp extract_namespace(conn, opts) do
    ns = opts[:namespace] || "teal/plugins/#{ExTealDirectUpload.Plugin.uri()}"
    Conn.assign(conn, :namespace, "/" <> ns)
  end

  defp random_string(length) do
    length |> :crypto.strong_rand_bytes() |> Base.url_encode64() |> binary_part(0, length)
  end
end
