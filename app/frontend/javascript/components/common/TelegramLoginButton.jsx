import fetchLink from "../../helpers/fetchLink";
import PropTypes from "prop-types";

class TelegramLoginButton extends React.Component {
  constructor (props) {
    super(props);

    this.login = this.login.bind(this);
    this.buttonScriptTag = this.buttonScriptTag.bind(this);
  }

  login (user) {
    const { callback } = this.props;

    fetchLink({
      link: "/api/v1/bot_login",
      method: "POST",
      body: JSON.stringify({
        user: {
          id: user.id,
          username: user.username,
          first_name: user.first_name,
          last_name: user.last_name,
          avatar_url: user.photo_url
        }
      }),
      onSuccess: () => {
        callback("true");
      },
      onFailure: () => {
        callback("false");
      }
    });
  }

  buttonScriptTag ({ size, radius, showUserpic }) {
    const script = document.createElement("script");
    script.src = "https://telegram.org/js/telegram-widget.js?7";
    script.async = true;
    script.setAttribute("data-telegram-login", "sr_gl_dev_lstpsche_bot");  // TODO: process.env.DOMAIN_BOT_NAME
    script.setAttribute("data-size", size);
    script.setAttribute("data-radius", radius);
    script.setAttribute("data-request-access", "write");
    script.setAttribute("data-userpic", showUserpic);
    script.setAttribute("data-onauth", "TelegramLoginWidget.dataOnauth(user)");

    return script;
  }

  componentDidMount () {
    window.TelegramLoginWidget = {
      dataOnauth: user => this.login(user)
    };

    const script = this.buttonScriptTag(this.props);
    this.instance.appendChild(script);
  }

  render () {
    return (
      <div className={"telegram-login-container " + this.props.className}>
        <div id="telegram-login-button"
          ref={component => {
            this.instance = component;
          }}
        />
      </div>
    );
  }
}

TelegramLoginButton.propTypes = {
  size: PropTypes.oneOf(["large", "medium", "small"]),
  radius: PropTypes.number,
  showUserpic: PropTypes.bool,
  callback: PropTypes.func
};

TelegramLoginButton.defaultProps = {
  size: "large",
  radius: 20,
  showUserpic: true
};

export default TelegramLoginButton;
