import { Link } from "react-router-dom";

class Home extends React.Component {
  render () {
    return (
      <div id="full-page-cover">
        <div className="content">
          <h1 className="cover-heading">
            {I18n.t("common.scheduler")}
          </h1>

          <p className="lead">
            {I18n.t("home.scheduler_overview")}
          </p>

          <p className="lead">
            <Link
              to="/sign_in"
              className="btn btn-lg btn-secondary"
              role="button"
            >
              {I18n.t("devise.registrations.sign_up")}
            </Link>
          </p>
        </div>
      </div>
    );
  }
}

export default Home;
