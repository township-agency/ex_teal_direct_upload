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

  get "/" do
    conn
    |> send_resp(200, "HELLO")
  end

  post "/sign" do
    file_name = conn.params["fileName"]
    mimetype = conn.params["contentType"]

    upload = %Uploader{
      file_name: file_name |> String.replace(~r/\s/, "-"),
      mimetype: mimetype,
      path: conn.params["path"] || "uploads"
    }

    send_resp(conn, 200, Uploader.presigned_json(upload))
  end

  defp extract_namespace(conn, opts) do
    ns = opts[:namespace] || "teal/plugins/#{ExTealDirectUpload.uri()}"
    Conn.assign(conn, :namespace, "/" <> ns)
  end
end
