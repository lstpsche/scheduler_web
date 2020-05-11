import { Link, Redirect } from "react-router-dom";
import UserContext from "./contexts/UserContext";
import UserDropdown from "./common/UserDropdown";
import TelegramLoginButton from "./common/TelegramLoginButton";

class Navbar extends React.Component {
  static contextType = UserContext;

  constructor (props) {
    super(props);

    this.state = {
      redirectTo: ""
    }

    this.userDropdown = this.userDropdown.bind(this);
    this.telegramLoginButton = this.telegramLoginButton.bind(this);
    this.onLogin = this.onLogin.bind(this);
  }

  userDropdown (user) {
    return (
      <UserDropdown user={user} />
    )
  }

  telegramLoginButton (callback) {
    return (
      <TelegramLoginButton
        className="nav-item my-2 my-md-0"
        size="medium"
        showUserpic={false}
        callback={callback}
      />
    )
  }

  onLogin () {
    window.location.reload();
  }

  render () {
    const user = this.context;
    const { redirectTo } = this.state;

    return (
      <nav className="navbar navbar-expand navbar-light bg-light global-navbar">
        { redirectTo ? <Redirect to={redirectTo} /> : null }
        <div className="container col-lg-7 col-md-10 col-sm-11 col-xs-auto">
          <Link
            to="/"
            className="navbar-brand"
          >
            {I18n.t("common.scheduler")}
          </Link>

          <div className="navbar-nav ml-auto">
            <ul className="navbar-nav mr-auto">
              {
                user.signedIn
                  ? this.userDropdown(user)
                  : this.telegramLoginButton(this.onLogin)
              }
            </ul>
          </div>
        </div>
      </nav>
    )
  }
};

export default Navbar;
