# Jay Heal
PrisonOffenderManager.create!(
  nomis_staff_id: 485737,
  status: 'active',
  working_pattern: 1
)

# Ross Jones
PrisonOffenderManager.create!(
  nomis_staff_id: 485752,
  status: 'active',
  working_pattern: 0.5
)

# Dom Bull
PrisonOffenderManager.create!(
  nomis_staff_id: 485572,
  status: 'active',
  working_pattern: 1
)

# Jenny Ducket
PrisonOffenderManager.create!(
  nomis_staff_id: 485636,
  status: 'active',
  working_pattern: 0.5
)

# Toby Retallick
PrisonOffenderManager.create!(
  nomis_staff_id: 485595,
  status: 'active',
  working_pattern: 1
)

AllocationService.create_allocation(
  {
    nomis_offender_id: 'G4273GI',
    nomis_booking_id: 1153753,
    prison: 'LEI',
    allocated_at_tier: 'C',
    created_by: 'user@username.com',
    nomis_staff_id: 485595
  })

AllocationService.create_allocation(
  {
    nomis_offender_id: 'G4273GI',
    nomis_booking_id: 1153753,
    prison: 'LEI',
    allocated_at_tier: 'A',
    created_by: 'user@username.com',
    nomis_staff_id: 485595
  })
