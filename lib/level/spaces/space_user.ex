defmodule Level.Spaces.SpaceUser do
  @moduledoc """
  The SpaceUser context.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Level.Spaces.Space
  alias Level.Users.User

  @type t :: %__MODULE__{}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "space_users" do
    field :state, :string, read_after_writes: true
    field :role, :string, read_after_writes: true
    belongs_to :space, Space
    belongs_to :user, User

    # Holds the group name when loaded via a join
    field :name, :string, virtual: true

    timestamps()
  end

  @doc false
  def create_changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:user_id, :space_id, :role])
    |> validate_required([:role])

    # TODO: add unique validation
  end
end
