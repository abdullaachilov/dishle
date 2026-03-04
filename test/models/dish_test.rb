require "test_helper"

class DishTest < ActiveSupport::TestCase
  test "validates presence of required fields" do
    dish = Dish.new
    assert_not dish.valid?
    assert_includes dish.errors[:name], "can't be blank"
    assert_includes dish.errors[:cuisine], "can't be blank"
    assert_includes dish.errors[:base], "can't be blank"
    assert_includes dish.errors[:protein], "can't be blank"
    assert_includes dish.errors[:star], "can't be blank"
    assert_includes dish.errors[:fat], "can't be blank"
    assert_includes dish.errors[:heat], "can't be blank"
  end

  test "validates uniqueness of name and slug" do
    existing = dishes(:carbonara)
    dish = Dish.new(name: existing.name, slug: "different", cuisine: "Test",
                    base: "a", protein: "b", star: "c", fat: "d", heat: "e")
    assert_not dish.valid?
    assert_includes dish.errors[:name], "has already been taken"
  end

  test "generates slug from name" do
    dish = Dish.new(name: "Test Dish", cuisine: "Test", base: "a", protein: "b",
                    star: "c", fat: "d", heat: "e", difficulty: "easy")
    dish.valid?
    assert_equal "test-dish", dish.slug
  end

  test "ingredients returns hash of all slots" do
    dish = dishes(:carbonara)
    ingredients = dish.ingredients
    assert_equal "Pasta", ingredients[:base]
    assert_equal "Egg", ingredients[:protein]
    assert_equal "Pecorino", ingredients[:star]
    assert_equal "Guanciale", ingredients[:fat]
    assert_equal "Black Pepper", ingredients[:heat]
  end

  test "compare_with returns correct for matching ingredients" do
    dish = dishes(:carbonara)
    result = dish.compare_with(dish)
    result.each_value do |v|
      assert_equal "correct", v[:result]
    end
  end

  test "compare_with returns absent for non-matching ingredients" do
    carbonara = dishes(:carbonara)
    pad_thai = dishes(:pad_thai)
    result = carbonara.compare_with(pad_thai)
    assert_equal "absent", result[:base][:result]    # Pasta vs Noodles
    assert_equal "absent", result[:protein][:result]  # Egg vs Shrimp
  end

  test "compare_with returns present when ingredient exists in different slot" do
    carbonara = dishes(:carbonara)
    bolognese = dishes(:bolognese)
    result = carbonara.compare_with(bolognese)
    assert_equal "correct", result[:base][:result]  # Both Pasta
  end
end
