defmodule ExTealDirectUpload.MixProject do
  use Mix.Project

  @version "0.8.1"

  @source "https://github.com/township-agency/ex_teal_direct_upload"

  def project do
    [
      app: :ex_teal_direct_upload,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      docs: docs(),
      name: "ExTealDirectUpload",
      source_url: @source
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_teal, ">= 0.16.0", organization: "motel"},
      {:ex_aws, "~> 2.3"},
      {:ex_aws_s3, "~> 2.3"},
      {:hackney, "~> 1.15"},
      {:plug, "~> 1.6"},
      {:jason, "~> 1.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "ExTealDirectUpload is a tool for managing images and files with direct upload to s3 and imgix proxying"
  end

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs README* priv),
      maintainers: [
        "Alexandrea Defreitas",
        "Scott Taylor"
      ],
      licenses: ["MIT"],
      organization: "motel",
      links: %{"GitHub" => @source}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md",
        "CHANGELOG.md"
      ],
      source_ref: "v#{@version}",
      source_url: @source
    ]
  end
end
