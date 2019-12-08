SCHEDULE_BUTTON = '.schedule-button'
SCHEDULE_BUTTON_CONTAINER = '.schedule-button-container'
SCHEDULE_FORM_ROW = '.schedule-form-row'

window.initializeSchedulesForms = ->
  $(SCHEDULE_BUTTON).each ->
    $button = $(this)

    if $button.hasClass('new')
      initializeNewScheduleFormButton($button)
    else
      initializeScheduleFormButton($button)

initializeNewScheduleFormButton = ($button) ->
  $button.closest('#new-schedule-form').click ->
    event.preventDefault()
    onScheduleButtonClick($(this))

initializeScheduleFormButton = ($button) ->
  $button.click ->
    event.preventDefault()
    onScheduleButtonClick($(this))

onScheduleButtonClick = ($button) ->
  $buttonContainer = $button.closest('tr')
  containerId = $buttonContainer.attr('id')
  $form = $buttonContainer.siblings().filter("[id=#{containerId}]")

  $buttonContainer.hide()
  showForm($form)
  initializeForm($form, $buttonContainer)

initializeForm = ($form, $buttonContainer) ->
  $('body').click (event) ->
    unless eventIsOnNewScheduleForm(event)
      $form.hide()
      $buttonContainer.show()

eventIsOnNewScheduleForm = (event) ->
  $(event.target).closest("#{SCHEDULE_FORM_ROW}, #{SCHEDULE_BUTTON_CONTAINER}").length

showForm = ($form) ->
  $form.show()
  $form.find('#schedule_name').focus()
