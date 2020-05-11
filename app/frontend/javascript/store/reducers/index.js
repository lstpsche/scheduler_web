import { combineReducers } from "redux";
import schedulesPage from "./schedulesPage";
import schedules from "./schedules";
import events from "./events";

export default combineReducers({
  schedulesPage,
  schedules,
  events
});
