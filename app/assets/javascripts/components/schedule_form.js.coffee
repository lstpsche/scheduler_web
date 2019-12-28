SCHEDULES_FORMS_BUTTONS = '.schedule-button, .new-schedule-button'
SCHEDULES_ROWS = '.schedule-row, .new-schedule-form'
SCHEDULES_ROWS_WITHOUT_ID = '.new-schedule-form'

window.initializeSchedulesForms = ->
  $(SCHEDULES_FORMS_BUTTONS).each ->
    $row = $(this).closest(SCHEDULES_ROWS)
    scheduleForm = new ScheduleForm($row)
    scheduleForm.initializeScheduleForm()

class ScheduleForm
  constructor: (@defaultRow) ->
    @formRow = @defaultRow.next('.schedule-form-row')
    @button = @defaultRow.find('.schedule-button')
    @scheduleId = @defaultRow.data('id')

  initializeScheduleForm: ->
    if @button.hasClass('edit')
      @initializeScheduleFormButton(@button)
    else if @button.hasClass('new')
      @initializeScheduleFormButton(@defaultRow)

  initializeScheduleFormButton: ($formToggleButton) ->
    $formToggleButton.click =>
      event.preventDefault()
      @onScheduleButtonClick()

  onScheduleButtonClick: ->
    @defaultRow.hide()
    @initializeForm()

  initializeForm: ->
    @showScheduleForm()

    $('body').click =>
      return if @eventIsOnScheduleForm(event)

      @hideScheduleForm()
      @defaultRow.show()

  showScheduleForm: ->
    @formRow.show()
    @formRow.find('#schedule_name').focus()

  hideScheduleForm: ->
    @formRow.off()
    @formRow.hide()

  eventIsOnScheduleForm: (event) ->
    $(event.target)
      .closest("#{SCHEDULES_ROWS}, .schedule-form-row")
      .filter("[data-id='#{@scheduleId}']")
      .length
