defmodule ExTealDirectUpload.MixProject do
  use Mix.Project

  @version "0.1.0"

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
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_teal, "~> 0.1", organization: "motel"},
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
      files: ~w(lib .formatter.exs mix.exs README*),
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
