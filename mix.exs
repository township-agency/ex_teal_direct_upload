defmodule ExTealDirectUpload.MixProject do
  use Mix.Project

  @source "https://github.com/township-agency/ex_teal_direct_upload"

  def project do
    [
      app: :ex_teal_direct_upload,
      version: "1.2.2",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      docs: docs(),
      name: "ExTealDirectUpload",
      source_url: @source,
      xref: [exclude: [ExTeal.Resource.Repo, :telemetry]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:plug, :ex_teal, :ex_aws, :ex_aws_s3]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_teal, ">= 0.27.0"},
      {:ex_aws, "~> 2.5"},
      {:ex_aws_s3, "~> 2.5"},
      {:ex_aws_sts, "~> 2.2", optional: true},
      {:hackney, "~> 1.15"},
      {:sweet_xml, "~> 0.6"},
      {:configparser_ex, "~> 4.0"},
      {:plug, "~> 1.14"},
      {:jason, "~> 1.0"},
      {:credo, "~> 1.7.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false}
    ]
  end

  defp description do
    "ExTealDirectUpload is a tool for managing images and files with direct upload to s3 and imgix proxying"
  end

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs README* priv),
      maintainers: [
        "Scott Taylor"
      ],
      licenses: ["MIT"],
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
      source_url: @source
    ]
  end
end
