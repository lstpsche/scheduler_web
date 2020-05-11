import {
  SET_SCHEDULES,
  ADD_SCHEDULE,
  UPDATE_SCHEDULE,
  REMOVE_SCHEDULE,
} from "../actionTypes/schedules";

export const setSchedules = (schedules) => ({
  type: SET_SCHEDULES,
  schedules
})

export const addSchedule = ({ id, name, additionalInfo }) => ({
  type: ADD_SCHEDULE,
  id, name, additionalInfo
})

export const updateSchedule = ({ id, name, additionalInfo }) => ({
  type: UPDATE_SCHEDULE,
  id, name, additionalInfo
})

export const removeSchedule = ({ id }) => ({
  type: REMOVE_SCHEDULE,
  id
})
