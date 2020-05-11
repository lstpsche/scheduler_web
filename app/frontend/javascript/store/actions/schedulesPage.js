import {
  SET_SCHEDULES_PAGE,
  INCREMENT_SCHEDULES_PAGE,
  DECREMENT_SCHEDULES_PAGE
} from "../actionTypes/schedulesPage";

export const setSchedulesPage = (newPage) => ({
  type: SET_SCHEDULES_PAGE,
  newPage
})

export const incrementSchedulesPage = () => ({
  type: INCREMENT_SCHEDULES_PAGE
})

export const decrementSchedulesPage = () => ({
  type: DECREMENT_SCHEDULES_PAGE
})
