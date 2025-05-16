defmodule MumblingTest do
  use ExUnit.Case
  use PropCheck
  alias Randomizer
  doctest Mumbling

  describe "mumbling specific testing" do
    test "when string is A then result is A" do
      assert Mumbling.mumble("A") == "A"
    end

    test "when string is a then result is A" do
      assert Mumbling.mumble("a") == "A"
    end

    test "when string is ab then result is A-Bb" do
      assert Mumbling.mumble("ab") == "A-Bb"
    end

    test "when string is AB then result is A-Bb" do
      assert Mumbling.mumble("AB") == "A-Bb"
    end

    test "when string is Ab then result is A-Bb" do
      assert Mumbling.mumble("Ab") == "A-Bb"
    end

    test "when string is aB then result is A-Bb" do
      assert Mumbling.mumble("aB") == "A-Bb"
    end

    test "when string is abc then result is A-Bb-Ccc" do
      assert Mumbling.mumble("abc") == "A-Bb-Ccc"
    end

    property "mumbling ", [:verbose] do
      forall length <- choose(2, 20) do
        text = Randomizer.randomizer(length, :alpha)
        head = String.slice(text, 0..(length - 2))
        tail = String.downcase String.last text
        assert Mumbling.mumble(text) == ~s(#{Mumbling.mumble(head)}-#{Mumbling.mumble(tail)}#{String.duplicate(tail, length - 1)})
      end
    end
  end

  describe "mumbling letter specific testing" do
    test "when string is A and count is 0 then result is A" do
      assert Mumbling.mumble_letter("A", 0) == "A"
    end

    test "when string is a and count is 0 then result is A" do
      assert Mumbling.mumble_letter("a", 0) == "A"
    end

    test "when string is a and count is 1 then result is Aa" do
      assert Mumbling.mumble_letter("a", 1) == "Aa"
    end

    test "when string is a and count is 2 then result is Aaa" do
      assert Mumbling.mumble_letter("a", 2) == "Aaa"
    end

    property "result with n duplicates concatenates result with one duplicate less and a single letter", [:verbose] do
      forall duplicates <- choose(1, 10) do
        assert Mumbling.mumble_letter("a", duplicates) == ~s(#{Mumbling.mumble_letter("a", duplicates - 1)}a)
      end
    end
  end

end