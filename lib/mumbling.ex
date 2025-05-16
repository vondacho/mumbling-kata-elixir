defmodule Mumbling do
  @moduledoc """
  This module provides a mumbling function which implements the behavior described in the Mumbling Kata:
  solution(“abcd”) should return “A-Bb-Ccc-Dddd”

  A two levels TDD approach is used and each cycle and subcycle is implemented by a specific private function.
  The mumble function is developed in an ATDD and TDD driven way. It uses the member_letter function.
  The member_letter function is developed in a TDD way.
  """

  def mumble(text) do
    mumble_5_refactored(text, 0, "")
  end

  defp mumble_1(text), do: "A"

  defp mumble_2(text), do: String.upcase text

  defp mumble_3(text) do
    cond do
      String.length(text) == 1 -> mumble_2 text
      true ->
        left = String.first text
        right = String.last text
        mumble_2(left) <> "-" <> mumble_2(right) <> right
    end
  end

  defp mumble_4(text) do
    cond do
      String.length(text) == 1 -> mumble_2 text
      true ->
        left = String.first text
        right = String.last text
        ~s(#{mumble_2(left)}-#{mumble_2(right)}#{String.downcase right})
    end
  end

  defp mumble_4_refactored(text) do
    cond do
      String.length(text) == 1 -> mumble_letter(text, 0)
      true -> ~s(#{mumble_letter(String.first(text), 0)}-#{mumble_letter(String.last(text), 1)})
    end
  end

  defp mumble_5(text, duplicates) do
    length = String.length text
    cond do
      length == 1 -> mumble_letter(text, duplicates)
      true ->
        head = String.first text
        tail = String.slice(text, 1..(length - 1))
        ~s(#{mumble_letter(head, duplicates)}-#{mumble_5(tail, duplicates + 1)})
    end
  end

  defp mumble_5_refactored(text, duplicates, acc) do
    length = String.length(text)
    cond do
      text == "" -> acc
      acc == "" ->
        head = String.first text
        tail = String.slice(text, 1..(length - 1))
        mumble_5_refactored(tail, duplicates + 1, mumble_letter(head, duplicates))
      true ->
        head = String.first text
        tail = String.slice(text, 1..(length - 1))
        mumble_5_refactored(tail, duplicates + 1, ~s(#{acc}-#{mumble_letter(head, duplicates)}))
    end
  end

  # single letter mumbling with duplicates

  def mumble_letter(letter, minor_occurrences) do
    mumble_letter_2_refactored(letter, minor_occurrences)
  end

  defp mumble_letter_1(letter, minor_occurrences), do: String.upcase letter

  defp mumble_letter_2(letter, minor_occurrences) do
    cond do
      minor_occurrences == 0 -> String.upcase letter
      true -> String.upcase(letter) <> String.downcase(letter)
    end
  end

  defp mumble_letter_2_refactored(letter, minor_occurrences) do
    String.capitalize(String.duplicate(letter, minor_occurrences + 1))
  end
end
