
class @BaseShortForm
  constructor: (@defaultRow, @subject) ->
    @formRow = @defaultRow.next('.form-row')
    @button = @defaultRow.find(".#{@subject}-button")
    @subjectId = @defaultRow.data('id')

  initializeForm: ->
    if @button.hasClass('edit')
      @initializeFormButton(@button)
    else if @button.hasClass('new')
      @initializeFormButton(@defaultRow)

  initializeFormButton: ($formToggleButton) ->
    $formToggleButton.click =>
      event.preventDefault()
      @onButtonClick()

  onButtonClick: ->
    @defaultRow.hide()
    @initializeFormRow()

  initializeFormRow: ->
    @showForm()

    $('body').click =>
      return if @eventIsOnForm(event)

      @hideForm()
      @defaultRow.show()

  showForm: (focusField, focusFieldAction) ->
    @formRow.show()
    focusFieldAction(@formRow.find(focusField))

  hideForm: ->
    $('body').off()
    @formRow.off().hide()
