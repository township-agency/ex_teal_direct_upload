defmodule ExTealDirectUpload do
  @moduledoc """
  Documentation for ExTealDirectUpload.
  """

  use ExTeal.Plugin

  def repo, do: nil

  def router, do: ExTealDirectUpload.Router

  def uri, do: "imgix"
end
