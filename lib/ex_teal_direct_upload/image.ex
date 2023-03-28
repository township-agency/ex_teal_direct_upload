defmodule ExTealDirectUpload.Image do
  @moduledoc """
  A  component that uses s3 as
  a proxy for fetching the asset
  """
  use ExTeal.Field
  alias ExTealDirectUpload.FieldHelpers

  def component, do: "image-field"

  def default_sortable, do: false

  def options, do: FieldHelpers.options()
end
