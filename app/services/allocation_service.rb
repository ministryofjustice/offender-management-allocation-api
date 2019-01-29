class AllocationService
  def self.create_allocation(params)
    Allocation.transaction do
      Allocation.where(offender_no: params[:offender_no]).update_all(active: false)
      Allocation.create(params) { |alloc|
        alloc.staff = StaffService.get_staff(params[:staff_id])
        alloc.active = true
        alloc.save!
      }
    end
  end
end
