import AdminUsersTable from "./components/AdminUsersTable";
import fetchLink from "../../../helpers/fetchLink";
import Loader from "../../common/Loader";

class AdminUsersTableTab extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      users: [],
      tableBlocked: false
    }

    this.getUsers = this.getUsers.bind(this);
    this.toggleTableBlock = this.toggleTableBlock.bind(this);
  }

  toggleTableBlock = (state) => this.setState({ tableBlocked: state })

  getUsers () {
    this.toggleTableBlock(true);

    fetchLink({
      link: "/api/v1/admin/users",
      onSuccess: ({ users }) => {
        this.setState({ users: users });
        this.toggleTableBlock(false);
      },
      onFailure: (error) => {
        this.toggleTableBlock(false);
        throw new Error(error);
      }
    });
  }

  componentDidMount () {
    this.getUsers();
  }

  render () {
    const { users, tableBlocked } = this.state;

    return (
      <div className="container users-table">
        <h2 className="admin-users-title my-3 mx-2">
          {I18n.t("admin_panel.users_table.header")}
        </h2>

        <button
          className="btn btn-outline-secondary mb-2 mx-3"
          onClick={this.getUsers}
        >
          { /* TODO: REDESIGN BUTTONS: this button should be smaller. Should be just FontAwesome sync-alt */ }
          Reload
        </button>

        <BlockUi tag="div" blocking={tableBlocked} loader={<Loader />} keepInView>
          <AdminUsersTable users={users} />
        </BlockUi>
      </div>
    )
  }
}

export default AdminUsersTableTab;
