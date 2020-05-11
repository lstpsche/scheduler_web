import PropTypes from "prop-types";
import UserContext from "../contexts/UserContext";
import NotFound from "../errors/NotFound";
import AdminPanelNavbar from "./AdminPanelNavbar";
import AdminUsersTableTab from "./tabs/AdminUsersTableTab";

class AdminPanel extends React.Component {
  static contextType = UserContext;

  constructor (props) {
    super(props);

    this.renderAdminPage = this.renderAdminPage.bind(this);
  }

  renderAdminPage (activeTab) {
    if (activeTab === "users_table_tab")
      return <AdminUsersTableTab />
  }

  render () {
    const user = this.context;

    if (user.admin !== true)
      return <NotFound />

    const { activeTab } = this.props;

    return (
      <div id="admin-panel">
        <AdminPanelNavbar activeTab={activeTab} />
        {this.renderAdminPage(activeTab)}
      </div>
    )
  }
}

AdminPanel.propTypes = {
  activeTab: PropTypes.string
}

AdminPanel.defaultProps = {
  activeTab: "users_table_tab"
}

export default AdminPanel;
