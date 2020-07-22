defmodule ExTealDirectUpload.Imgix do
  @moduledoc """
  A  component that uses imgix as
  a proxy for fetching the asset
  """
  use ExTeal.Field
  alias ExTealDirectUpload.FieldHelpers

  def component, do: "imgix-field"

  def default_sortable, do: false

  def options, do: FieldHelpers.options()
end
