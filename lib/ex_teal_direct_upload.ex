defmodule ExTealDirectUpload do
  @moduledoc """
  Documentation for ExTealDirectUpload.
  """

  use ExTeal.Plugin

  alias ExTeal.Asset.Script

  def repo, do: nil

  def router, do: ExTealDirectUpload.Router

  def uri, do: "imgix"

  def scripts, do: [%Script{path: "js/field.js"}]
end
