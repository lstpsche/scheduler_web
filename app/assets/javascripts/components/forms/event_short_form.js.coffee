EVENTS_FORMS_BUTTONS = '.event-button, .new-event-button'
SUBJECT_ROWS = '.event-row, .new-event-form'
CLICKABLE_ELEMENTS_CLASSES = ['event-row', 'new-event-form', 'form-row']
TIME_PICKER = '.picker'

window.initializeEventsShortForms = ->
  $(EVENTS_FORMS_BUTTONS).each ->
    $row = $(this).closest(SUBJECT_ROWS)
    eventForm = new EventShortForm($row)
    eventForm.initializeForm()

class EventShortForm extends BaseShortForm
  constructor: ($defaultRow) ->
    super($defaultRow, 'event')

  showForm: ->
    super('#event_time', ($element) ->)

  eventIsOnForm: (event) ->
    $element = $(event.target).closest("#{SUBJECT_ROWS}, .form-row")

    if @hasClass($element, CLICKABLE_ELEMENTS_CLASSES)
      return $element.filter("[data-id='#{@subjectId}']").length
    else
      return $(event.target).closest(TIME_PICKER).length

  hasClass: ($element, classes) ->
    return false unless $element.length

    for elemClass in classes
      return true if $element.hasClass(elemClass)
