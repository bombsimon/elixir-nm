defmodule Nm do
  @moduledoc """
  Nim is a mathematical game of strategy in which two players take turns
  removing objects from distinct heaps. On each turn, a player must remove at
  least one object, and may remove any number of objects provided they all come
  from the same heap. The goal of the game is to be the player who removes the
  last object.
    - Wikipedia
  """

  @doc """
  Start the game with desired amount of objects.

  ## Examples

      iex> Nm.play(20)
      ...
      "Game over!"
  """
  def play(starting_stack) do
    stack = starting_stack

    IO.puts "Stack has #{stack} objects - remove more than one but no more than half each move!"

    run(stack)
  end

  @doc """
  Runs the loop which asks for new moves until the last object is removed"
  """
  def run(stack) do
    case stack do
      x when x == 1 ->
        "Game over!"
      _ -> 
        # Move based on input
        stack = get_move() |> make_move(stack)

        if stack > 1 do
          # Move based on generated move
          stack = generate_move(stack) |> make_move(stack)
        end

        run(stack)
    end
  end

  @doc """
  Make move will try to execute the mvoe and check if it was valid. If not new
  input will be prompted. If successful the remainder will be returned.

  ## Examples

      iex> Nm.make_move(2, 10)
      8
  """
  def make_move(to_remove, stack) do
    {remainder, message, valid} = remove_object(stack, to_remove)

    if !valid do
      IO.puts message

      get_move()
      |> make_move(stack)
    else
      IO.puts "#{to_remove} objects was remvoed - #{remainder} is left"
      remainder
    end
  end

  @doc """
  Take input from a user and use as a move

  ## Examples

      iex> Nm.get_move()
      Objects to remove: 6
      6
  """
  def get_move do
    i = IO.gets ">>> Objects to remove: "

    case Integer.parse(i) do
      x when x  == :error ->
        IO.puts "Not a number, try again"
        get_move()
      {_, ok} when ok != "\n" ->
        IO.puts "Not a valid integer (single digit), try again"
        get_move()
      {x, _} -> x
    end
  end

  @doc """
  Generates a valid move based on game rules.

  ## Examples

      iex> Nm.generate_move(10)
      4
  """
  def generate_move(stack) do
    Kernel.trunc(stack/2)
    |> :rand.uniform()
  end

  @doc """
  Remove objects from a given stack. Takes two integers as input and ensures move is valid.

  ## Examples

      iex> Nm.remove_object(10, 2)
      {8, "ok", true}
  """
  def remove_object(stack, to_remove) do
    case to_remove do
      x when x < 1 ->
        {stack, "Invalid move, a player have to draw more than 0 objects", false}
      x when x > stack ->
        {stack, "Invalid move, was more than the stack holds", false}
      x when x > (stack / 2) ->
        {stack, "Invalid move, cannot remove more than halft the stack", false}
      _ ->
        {stack - to_remove, "Ok", true}

    end
  end
end
