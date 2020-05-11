import PropTypes from "prop-types";
import { Link } from "react-router-dom";

class AdminPanelNavbar extends React.Component {
  constructor (props) {
    super(props);

    this.tabClassName = this.tabClassName.bind(this);
  }

  tabClassName (tabName) {
    const activeTab = this.props.activeTab || "users_table_tab";
    var tabClass = "nav-link tab-link ";

    if (activeTab === tabName)
      return tabClass.concat("active");
    return tabClass;
  }

  render () {
    return (
      <nav id="admin-navbar" className="navbar navbar-expand navbar-light bg-light admin-panel-navbar">
        <div className="navbar-collapse justify-content-center">
          <ul className="navbar-nav">
            <li className="nav-item">
              <Link
                id="users-table-tab"
                to="/admin_panel/users_table"
                className={this.tabClassName("users_table_tab")}
              >
                {I18n.t("admin_panel.tabs.users_table")}
              </Link>
            </li>
          </ul>
        </div>
      </nav>
    )
  }
}

AdminPanelNavbar.propTypes = {
  activeTab: PropTypes.string
}

AdminPanelNavbar.defaultProps = {
  activeTab: "users_table_tab"
}

export default AdminPanelNavbar;
