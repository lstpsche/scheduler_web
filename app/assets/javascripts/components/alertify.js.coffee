$ ->
  DEFAULT_SETTINGS = Object.freeze({
    maximizable: false,
    movable: false,
    moveBounded: false,
    pinnable: false,
    pinned: false,
    resizable: false,
    transition: 'fade',
    transitionOff: false
  })

  alertify.alert().set(DEFAULT_SETTINGS)
  alertify.confirm().set(DEFAULT_SETTINGS)
  alertify.prompt().set(DEFAULT_SETTINGS)

  alertify.set 'notifier', 'delay', 3
  alertify.set 'notifier', 'position', 'bottom-right'
  alertify.set 'notifier', 'closeButton', 'false'
