defmodule Level.Groups.Group do
  @moduledoc """
  The Group schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Level.Groups.Group
  alias Level.Spaces.Space
  alias Level.Spaces.SpaceUser

  @type t :: %__MODULE__{}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "groups" do
    field :state, :string, read_after_writes: true
    field :name, :string
    field :description, :string
    field :is_private, :boolean, default: false

    belongs_to :space, Space
    belongs_to :creator, SpaceUser

    timestamps()
  end

  @doc false
  def create_changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:creator_id, :space_id, :name, :description, :is_private])
    |> validate()
  end

  @doc false
  def update_changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :description, :is_private])
    |> validate()
  end

  @doc false
  def validate(changeset) do
    changeset
    |> validate_required([:name])
    |> unique_constraint(:name, name: :groups_unique_names_when_open)
  end
end
