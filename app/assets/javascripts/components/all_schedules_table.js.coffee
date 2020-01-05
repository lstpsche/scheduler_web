window.initializeSchedulesTable = ->
  $table = $('#schedules-listing')

  initializeScheduleRows($table)

initializeScheduleRows = ($table) ->
  $table.find('.schedule-row').click ->
    return if $(event.target).closest("[class*='schedule-actions']").length

    scheduleId = $(this).data().id

    $("#schedule_#{scheduleId}").click()
