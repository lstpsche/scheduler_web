window.initializeSchedulesTable = ->
  $table = $('#schedules-listing')

  initializeScheduleRows($table)

initializeScheduleRows = ($table) ->
  $table.find('.schedule-row').each (_index, scheduleRow) ->
    $(scheduleRow).click ->
      scheduleId = $(this).data().id

      $("#schedule_#{scheduleId}").click()
