window.initializeSchedulesTable = ->
  $table = $('#schedules-listing')

  initializeScheduleRows($table)

initializeScheduleRows = ($table) ->
  $table.find('.schedule-info-row').each (_index, scheduleRow) ->
    $(scheduleRow).click ->
      return if $(event.target).closest('[id$="-options"]').length

      scheduleId = $(this).data().id

      $("#schedule_#{scheduleId}").click()