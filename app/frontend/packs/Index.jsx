import { render } from "react-dom";
import { Provider } from "react-redux";
import store from "../javascript/store/schedulerStore";
import App from "../javascript/components/App";

// TODO: add dynamic setting locale depending on user lagnuage
// I18n.locale = current_user.language_code

document.addEventListener("DOMContentLoaded", () => {
  render (
    <Provider store={store}>
      <App />
    </Provider>,
    document.body.appendChild(document.createElement("div"))
  );
});
