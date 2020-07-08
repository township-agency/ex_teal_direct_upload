defmodule ExTealDirectUpload.ImgixArray do
  @moduledoc """
  A component for managing an array of imgix assets
  """
  use ExTeal.Field
  alias ExTeal.Field

  def component, do: "imgix-array-field"

  def options do
    bucket = Application.get_env(:ex_teal_direct_upload, :aws_s3_bucket)
    region = Application.get_env(:ex_teal_direct_upload, :aws_region)
    imgix = Application.get_env(:ex_teal_direct_upload, :imgix_source)
    presign_s3_urls = Application.get_env(:ex_teal_direct_upload, :presign_s3_urls)

    height = "64"
    width = "64"

    %{
      imgix_host: imgix,
      s3_host: "s3.#{region}.amazonaws.com/#{bucket}",
      type: "imgix",
      height: height,
      width: width,
      presign_s3_urls: presign_s3_urls
    }
  end

  @doc """
  Enable a draggable ui for the field, allowing a user to reorder the items in the array
  """
  @spec draggable(Field.t()) :: Field.t()
  def draggable(%Field{options: options} = field) do
    opts = Map.merge(options, %{draggable: true})
    %{field | options: opts}
  end

  @doc """
  Put the 'add item' at the bottom of the list instead of the tops
  """
  @spec list_above(Field.t()) :: Field.t()
  def list_above(%Field{options: options} = field) do
    opts = Map.merge(options, %{list_first: false})
    %{field | options: opts}
  end

  @doc """
  Hide the 'create button' in the user interface
  """
  @spec hide_create_button(Field.t()) :: Field.t()
  def hide_create_button(%Field{options: options} = field) do
    opts = Map.merge(options, %{hide_create_button: true})
    %{field | options: opts}
  end

  @doc """
  Set a maximum number of items in the list
  """
  @spec max_items(Field.t(), integer()) :: Field.t()
  def max_items(%Field{options: options} = field, value) do
    opts = Map.merge(options, %{max: value})
    %{field | options: opts}
  end

  @doc """
  Set a maximum height of the list in pixels
  """
  @spec max_height(Field.t(), integer()) :: Field.t()
  def max_height(%Field{options: options} = field, value) do
    opts = Map.merge(options, %{max_height: value})
    %{field | options: opts}
  end

  @doc """
  Set the placeholder for the 'add item' inputs
  """
  @spec placeholder(Field.t(), String.t()) :: Field.t()
  def placeholder(%Field{options: options} = field, value) do
    opts = Map.merge(options, %{placeholder: value})
    %{field | options: opts}
  end
end
