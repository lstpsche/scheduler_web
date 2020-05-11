// Schedules tree structure:
//
// schedules: [
//   {
//     id: scheduleId,
//     name: scheduleName,
//     additionalInfo: scheduleAdditionalInfo
//   }
// ]

import {
  SET_SCHEDULES,
  ADD_SCHEDULE,
  UPDATE_SCHEDULE,
  REMOVE_SCHEDULE
} from "../actionTypes/schedules";

function schedules (state = [], action) {
  const { type: actionType, id, name, additionalInfo } = action;

  switch (actionType) {
    case SET_SCHEDULES:
      return action.schedules
    case ADD_SCHEDULE:
      return [
        ...state,
        { id, name, additionalInfo }
      ]
    case UPDATE_SCHEDULE:
      return state.map (schedule =>
        schedule.id === id ? { ...schedule, name, additionalInfo } : schedule
      )
    case REMOVE_SCHEDULE:
      return state.filter(({ id: scheduleId }) => scheduleId !== id)
    default:
      return state
  }
}

export default schedules;
