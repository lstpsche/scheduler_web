import {
  SET_EVENTS,
  ADD_EVENT,
  UPDATE_EVENT,
  REMOVE_EVENT
} from "../actionTypes/events";

export const setEvents = ({ scheduleId, events }) => ({
  type: SET_EVENTS,
  scheduleId, events
})

export const addEvent = ({ scheduleId, id, weekday, time, info, additionalInfo }) => ({
  type: ADD_EVENT,
  scheduleId, id,
  weekday, time, info, additionalInfo
})

export const updateEvent = ({ scheduleId, id, weekday, time, info, additionalInfo }) => ({
  type: UPDATE_EVENT,
  scheduleId, id,
  weekday, time, info, additionalInfo
})

export const removeEvent = ({ scheduleId, id }) => ({
  type: REMOVE_EVENT,
  scheduleId, id
})
