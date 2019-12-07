NEW_SCHEDULE_BUTTON_ROW = '#new-schedule-button-row'
NEW_SCHEDULE_FORM_ROW = '#new-schedule-form-row'

window.initializeNewScheduleButton = ->
  $('#new-schedule-button').click (event) ->
    event.preventDefault()

    $button = $(this).closest(NEW_SCHEDULE_BUTTON_ROW)
    $form = $(NEW_SCHEDULE_FORM_ROW)

    hideButton($button)
    showForm($form)
    initializeForm($form, $button)

initializeForm = ($form, $button) ->
  $('body').click (event) ->
    unless eventIsOnNewScheduleForm(event)
      hideForm($form)
      showButton($button)

eventIsOnNewScheduleForm = (event) ->
  $(event.target).closest('#new-schedule-form-row, #new-schedule-button-row').length

showButton = ($button) ->
  $button.show()

showButton = ($button) ->
  $button.show()

hideButton = ($button) ->
  $button.hide()

showForm = ($form) ->
  $form.show()
  $form.find('#schedule_name').focus()

hideForm = ($form) ->
  $form.hide()
