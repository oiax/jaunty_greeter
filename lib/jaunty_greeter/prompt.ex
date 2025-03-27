defmodule Prompt do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:title, :string)
    field(:dialect, :string)
  end

  @field_names [:title, :dialect]

  def changeset(prompt, attrs \\ %{}) do
    prompt
    |> cast(attrs, @field_names)
    |> validate_required(@field_names)
  end
end
