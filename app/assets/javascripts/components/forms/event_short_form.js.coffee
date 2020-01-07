EVENTS_FORMS_BUTTONS = '.event-button, .new-event-button'
SUBJECT_ROWS = '.event-row, .new-event-form'

window.initializeEventsShortForms = ->
  $(EVENTS_FORMS_BUTTONS).each ->
    $row = $(this).closest(SUBJECT_ROWS)
    eventForm = new EventShortForm($row)
    eventForm.initializeForm()

class EventShortForm extends BaseShortForm
  constructor: (defaultRow) ->
    super(defaultRow, 'event')


  showForm: ->
    super('#event_time', ($element) ->
      $element.click()
    )
