$ ->
  Picker.setDefaults({
    container: '.picker-container',
    controls: true,
    # date: by default uses current date,
    format: 'HH:mm MMM D, YYYY',
    headers: true,
    increment: {
      year: 1,
      month: 1,
      day: 1,
      hour: 1,
      minute: 1,
      second: 1,
      millisecond: 1
    },
    inline: false,
    # language: ISO code of lang
    # months: array of strings with full months names
    # monthsShort: array of strings with short months names
    rows: 3,
    text: {
      title: 'Pick a date and time',
      cancel: 'Cancel',
      confirm: 'OK',
      year: 'Year',
      month: 'Month',
      day: 'Day',
      hour: 'Hour',
      minute: 'Minute',
      second: 'Second',
      millisecond: 'Millisecond'
    },
    # show: ->
    # shown: ->
    # hide: ->
    # hidden: ->
    # pick: ->
  })

  window.createDateTimePicker = (elementClass, options) ->
    elements = $(elementClass)
    return unless elements.length

    for element in elements
      new Picker(element, options)
