defmodule Honeydew.Please.Commands.DiscardList do
  @moduledoc """
  Command to mark list as discarded.
  """

  use Blunt.Command
  use Blunt.Command.EventDerivation

  field :list_id, :honeydew_id
  field :notes, :string

  derive_event Honeydew.Please.Events.ListDiscarded do
    @moduledoc """
    Event that signals a list was discarded.
    """
    field :status, :list_status, default: :discarded
  end
end
