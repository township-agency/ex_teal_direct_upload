defmodule ExTealDirectUpload.MixProject do
  use Mix.Project

  @version "0.5.0"

  @source "https://gitlab.motel-lab.com/teal/ex_teal_direct_upload"

  def project do
    [
      app: :ex_teal_direct_upload,
      version: @version,
      elixir: "~> 1.7",
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
      applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_teal, "~> 0.4", organization: "motel"},
      {:ex_aws, "~> 2.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:hackney, "~> 1.15"},
      {:plug, "~> 1.6"},
      {:jason, "~> 1.0"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
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
        "Caleb Oller",
        "Lydia Koller",
        "Samina Khan",
        "Scott Taylor"
      ],
      licenses: ["MIT"],
      organization: "motel",
      links: %{"GitLab" => @source}
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
