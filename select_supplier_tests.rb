# frozen_string_literal: true

require './select_supplier'
require 'test/unit'

class SelectSupplierTests < Test::Unit::TestCase
  def setup
    @suppliers = [
      {
        name: "FunePlus",
        advitam_grade: 3,
        works: [
          { type: "embalming", price: 350 },
          { type: "transport_before_casketing", price: 450 }
        ]
      },
      {
        name: "FuneTop",
        works: [
          { type: "graving", price: 10 }
        ]
      },
      {
        name: "FuneTruc",
        advitam_grade: 5,
        works: [
          { type: "embalming", price: 750 }
        ]
      },
      {
        name: "FuneCorp",
        advitam_grade: 2,
        works: [
          { type: "digging", price: 350 }
        ]
      },
    ]
    @select = SelectSupplier.new(@suppliers)
  end

  def test_grade_weight
    assert_equal(1, @select.grade_weight)
    @select.grade_weight = 5
    assert_equal(5, @select.grade_weight)
  end

  def test_suppliers
    assert_equal(
      [
        {
          name: "FuneTruc",
          advitam_grade: 5,
          works: [
            { type: "embalming", price: 750 }
          ]
        },
        {
          name: "FunePlus",
          advitam_grade: 3,
          works: [
            { type: "embalming", price: 350 },
            { type: "transport_before_casketing", price: 450 }
          ]
        },
        {
          name: "FuneCorp",
          advitam_grade: 2,
          works: [
            { type: "digging", price: 350 }
          ]
        },
        {
          name: "FuneTop",
          works: [
            { type: "graving", price: 10 }
          ]
        },
      ],
      @select.suppliers
    )
  end

  def test_supplier_grade
    assert_equal(nil, @select.supplier_grade("unknown", "embalming"))

    assert_equal(nil, @select.supplier_grade("FunePlus", "unknown"))

    assert_equal(353, @select.supplier_grade("FunePlus", "embalming"))
    assert_equal(453, @select.supplier_grade("FunePlus", "transport_before_casketing"))

    @select.grade_weight = 5

    assert_equal(365, @select.supplier_grade("FunePlus", "embalming"))
    assert_equal(465, @select.supplier_grade("FunePlus", "transport_before_casketing"))
  end

  def test_work_all
    assert_equal([], @select.work_all("unknown"))

    assert_equal(
      [
        {
          name: "FunePlus",
          advitam_grade: 3,
          works: [
            { type: "embalming", price: 350 },
            { type: "transport_before_casketing", price: 450 }
          ]
        },
        {
          name: "FuneTruc",
          advitam_grade: 5,
          works: [
            { type: "embalming", price: 750 }
          ]
        },
      ],
      @select.work_all("embalming")
    )
  end

  def test_work
    assert_equal(nil, @select.work("unknown"))

    assert_equal(
      {
        name: "FunePlus",
        advitam_grade: 3,
        works: [
          { type: "embalming", price: 350 },
          { type: "transport_before_casketing", price: 450 }
        ]
      },
      @select.work("embalming")
    )
  end
end