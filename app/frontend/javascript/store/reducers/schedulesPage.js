// schedulesPage format in store
//
// schedulesPage: schedulesPageNumber

import {
  SET_SCHEDULES_PAGE,
  INCREMENT_SCHEDULES_PAGE,
  DECREMENT_SCHEDULES_PAGE
} from "../actionTypes/schedulesPage";

function schedulesPage (state = 0, action) {
  switch (action.type) {
    case SET_SCHEDULES_PAGE:
      return action.newPage
    case INCREMENT_SCHEDULES_PAGE:
      return state + 1;
    case DECREMENT_SCHEDULES_PAGE:
      return state - 1;
    default:
      return state;
  }
}

export default schedulesPage;
