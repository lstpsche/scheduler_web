$ ->
  $('.schedules.pagination a.page-link').click ->
    event.preventDefault()
    window.location = $(event.target).attr('href')

    window.initializeSchedulesForms()
    window.initializeSchedulesTable()
