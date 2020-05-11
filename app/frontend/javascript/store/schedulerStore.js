import { createStore } from "redux";
import reducers from "./reducers/index";

const defaultStoreValue = {
  schedulesPage: 0,
  schedules: [],
  events: {}
}

export default createStore(reducers, defaultStoreValue);
