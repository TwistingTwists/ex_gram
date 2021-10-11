defmodule ExGram.Responses.SendPoll do
  @moduledoc """
  Poll, it uses `send_poll`
  """

  defstruct [:id, :question, :options, :ops]
end

defimpl ExGram.Responses, for: ExGram.Responses.SendPoll do
  def new(response, params), do: struct(response, params)

  def execute(poll) do
    ExGram.send_poll(poll.id, poll.question, poll.options, poll.ops)
  end

  def set_msg(%{id: nil} = response, msg) do
    %{response | id: ExGram.Dsl.extract_id(msg)}
  end

  def set_msg(response, _msg), do: response
end
