defmodule Honeydew.Please.Queries.ListTasksPipeline do
  use Cqrs.QueryPipeline

  alias Cqrs.Query
  alias Honeydew.Repo
  alias Honeydew.Please.Projections.Task

  @impl true
  def create_query(filters, context) do
    preload = Query.preload(context)
    query = from t in Task, as: :task, preload: ^preload

    Enum.reduce(filters, query, fn
      {:list_id, list_id}, query -> from [list: l] in query, where: l.list_id == ^list_id
    end)
  end

  @impl true
  def handle_dispatch(query, _context, opts) do
    Repo.all(query, opts)
  end
end