defmodule Banchan.Commissions.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "line_items" do
    field :amount, Money.Ecto.Composite.Type
    field :description, :string
    field :name, :string

    belongs_to :commission, Banchan.Commissions.Commission
    belongs_to :option, Banchan.Offerings.OfferingOption

    timestamps()
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:amount, :name, :description])
    |> cast_assoc(:commission)
    |> cast_assoc(:option)
    |> validate_money(:amount)
    |> validate_required([:amount, :name, :description])
  end

  defp validate_money(changeset, field) do
    validate_change(changeset, field, fn
      _, %Money{} -> []
      _, _ -> [{field, "must be an amount"}]
    end)
  end
end