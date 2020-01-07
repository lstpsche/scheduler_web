SCHEDULES_FORMS_BUTTONS = '.schedule-button, .new-schedule-button'
@SUBJECT_ROWS = '.schedule-row, .new-schedule-form'

window.initializeSchedulesShortForms = ->
  $(SCHEDULES_FORMS_BUTTONS).each ->
    $row = $(this).closest(SUBJECT_ROWS)
    scheduleForm = new ScheduleShortForm($row)
    scheduleForm.initializeForm()

class ScheduleShortForm extends BaseShortForm
  constructor: (defaultRow) ->
    super(defaultRow, 'schedule')

  showForm: ->
    super('#schedule_name', ($element) ->
      $element.focus()
    )
