class SelectSupplier
  def initialize(suppliers)
    @suppliers = []
    @suppliers = Array(suppliers) unless suppliers.nil?
    @grade_weight = 1
  end

  def work(work_type)
    work_all(work_type).first
  end

  def work_all(work_type)
    suppliers = @suppliers.find_all do |supplier|
      supplier[:works].any? do |work|
        work[:type] == work_type
      end
    end
    suppliers.sort_by do |supplier|
      work = supplier[:works].find do |work|
        work[:type] == work_type
      end
      get_global_grade(supplier, work)
    end
  end

  def suppliers
    @suppliers.sort_by do |supplier|
      get_advitam_grade(supplier)
    end .reverse
  end

  def supplier_grade(supplier_name, work_type)
    supplier = @suppliers.find do |supplier|
      supplier[:name] == supplier_name
    end
    return unless supplier
    work = supplier[:works].find do |work|
      work[:type] == work_type
    end
    return unless work
    get_global_grade(supplier, work)
  end

  def grade_weight
    @grade_weight
  end

  def grade_weight=(grade_weight)
    @grade_weight = grade_weight
  end

  private

  def get_advitam_grade(supplier)
    supplier[:advitam_grade] || 0
  end

  def get_global_grade(supplier, work)
    @grade_weight * get_advitam_grade(supplier) + work[:price]
  end
end