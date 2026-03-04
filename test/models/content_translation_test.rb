require "test_helper"

class ContentTranslationTest < ActiveSupport::TestCase
  test "validates locale inclusion" do
    ct = ContentTranslation.new(locale: "xx", category: "ingredient", key: "Test", value: "Тест")
    assert_not ct.valid?
    assert_includes ct.errors[:locale], "is not included in the list"
  end

  test "validates category inclusion" do
    ct = ContentTranslation.new(locale: "ru", category: "invalid", key: "Test", value: "Тест")
    assert_not ct.valid?
    assert_includes ct.errors[:category], "is not included in the list"
  end

  test "validates key uniqueness per locale and category" do
    existing = content_translations(:pasta_ru)
    ct = ContentTranslation.new(locale: existing.locale, category: existing.category,
                                key: existing.key, value: "Different")
    assert_not ct.valid?
    assert_includes ct.errors[:key], "has already been taken"
  end

  test "grouped_by_locale returns structured data" do
    result = ContentTranslation.grouped_by_locale("ru")
    assert_equal "Паста", result[:ingredients]["Pasta"]
    assert_equal "Томат", result[:ingredients]["Tomato"]
  end
end
