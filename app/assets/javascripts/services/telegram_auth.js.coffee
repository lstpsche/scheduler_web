class @TelegramAuth
  @login: (user) ->
    $.ajax({
      type: 'post',
      url: '/bot_login',
      dataType: 'json',
      data: @data(user),
      success: ->
        location.reload()
      error: ->
        alert('Something went wrong.')
    })

  @data: (user) ->
    {
      user: {
        id: user.id,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name
      }
    }
