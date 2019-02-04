class AllocationService
  def self.create_allocation(params)
    Allocation.transaction do
      Allocation.where(offender_no: params[:offender_no]).update_all(active: false)
      Allocation.create!(params) { |alloc|
        alloc.prison_offender_manager = PrisonOffenderManagerService.
          get_prison_offender_manager(params[:nomis_staff_id])
        alloc.active = true
        alloc.save!
      }
    end
  end

  def self.active_allocations(offender_ids)
    Allocation.where(offender_id: offender_ids, active: true).map { |a|
      [
        a[:offender_id],
        a
      ]
    }.to_h
  end
end
