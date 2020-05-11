import PropTypes from "prop-types";

class AdminUsersTable extends React.Component {
  constructor (props) {
    super(props);

    this.userTableRow = this.userTableRow.bind(this);
  }

  userTableRow (userData, index) {
    const { id } = userData;
    const {
      username: tgUsername, first_name: firstName,
      last_name: lastName, language_code: languageCode
    } = userData.attributes;

    return (
      <tr key={index}>
        <td>{id}</td>
        <td>TODO: User avatar here</td>
        <td>{tgUsername}</td>
        <td>{firstName}</td>
        <td>{lastName}</td>
        <td>{languageCode}</td>
      </tr>
    )
  }

  render () {
    const { users } = this.props;

    return (
      <div className="events-table horizontal-scrollable">
        <table className="table table-striped">
          <thead>
            <tr>
              <th scope="col">{I18n.t("admin_panel.users_table.user.id")}</th>
              <th>{I18n.t("admin_panel.users_table.user.avatar")}</th>
              <th>{I18n.t("admin_panel.users_table.user.telegram_username")}</th>
              <th>{I18n.t("admin_panel.users_table.user.first_name")}</th>
              <th>{I18n.t("admin_panel.users_table.user.last_name")}</th>
              <th>{I18n.t("admin_panel.users_table.user.language_code")}</th>
            </tr>
          </thead>
          <tbody>
            {
              users.length
                ? users.map((user, index) => this.userTableRow(user.data, index))
                : null
            }
          </tbody>
        </table>
      </div>
    )
  }
}

AdminUsersTable.propTypes = {
  users: PropTypes.array.isRequired
}

export default AdminUsersTable;
