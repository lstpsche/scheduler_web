// Events tree structure:
//
// events: {
//   [scheduleId]: [
//     {
//       [id]: eventId,
//       [weekday]: eventWeekday,
//       [time]: eventTime,
//       [info]: eventInfo,
//       [additionalInfo]: eventAdditionalInfo
//     },
//     {
//       [id]: eventId,
//       [weekday]: eventWeekday,
//       [time]: eventTime,
//       [info]: eventInfo,
//       [additionalInfo]: eventAdditionalInfo
//     }
//   ]
// }

import {
  SET_EVENTS,
  ADD_EVENT,
  UPDATE_EVENT,
  REMOVE_EVENT
} from "../actionTypes/events";

function events (state = {}, action) {
  const { type: actionType, scheduleId, events, id, weekday, time, info, additionalInfo } = action;

  switch (actionType) {
    case SET_EVENTS:
      return { ...state, [scheduleId]: events }
    case ADD_EVENT:
      return {
        ...state,
        [scheduleId]: [
          ...state[scheduleId],
          { scheduleId, id, weekday, time, info, additionalInfo }
        ]
      }
    case UPDATE_EVENT:
      return {
        ...state,
        [scheduleId]:
          state[scheduleId].map(event =>
            event.id === id ? { scheduleId, id, weekday, time, info, additionalInfo } : event
          )
      }
    case REMOVE_EVENT:
      return {
        ...state,
        [scheduleId]:
          state[scheduleId].filter(({ id: eventId }) => eventId !== id)
      }
    default:
      return state
  }
}

export default events;
