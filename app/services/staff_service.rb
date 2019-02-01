class StaffService
  def self.get_staff(staff_id)
    Staff.find_or_create_by!(staff_id: staff_id) { |s|
      s.working_pattern = s.working_pattern || '0'
      s.status = s.status || 'inactive'
    }
  end

  def self.get_poms(staff_ids)
    Staff.includes(:allocations).where(staff_id: staff_ids)
  end
end
