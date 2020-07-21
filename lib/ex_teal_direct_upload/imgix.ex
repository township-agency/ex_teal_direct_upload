defmodule ExTealDirectUpload.Imgix do
  @moduledoc """
  A  component that uses imgix as
  a proxy for fetching the asset
  """
  use ExTeal.Field
  import ExTealDirectUpload.FieldHelpers, only: [options: 0, custom_width_and_height: 3]

  def component, do: "imgix-field"

  @impl true
  def default_sortable, do: false
end
