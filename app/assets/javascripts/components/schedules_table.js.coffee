window.initializeSchedulesTable = ->
  $table = $('#schedules-listing')

  initializeScheduleRows($table)

initializeScheduleRows = ($table) ->
  $table.find('.schedule-row').each (_index, scheduleRow) ->
    $(scheduleRow).click ->
      return if $(event.target).filter('span.schedule-name, span.schedule-add').length

      scheduleId = $(this).data().id

      $("#schedule_#{scheduleId}").click()
