import Dropdown from "./Dropdown/Dropdown";

class UserDropdown extends React.Component {
  constructor (props) {
    super(props);

    this.header = this.header.bind(this);
    this.itemsList = this.itemsList.bind(this);
  }

  header ({first_name: firstName, last_name: lastName}) {
    return (
      {
        title: firstName + " " + lastName,
        className: "btn nav-link",
        id: "user-dropdown"
      }
    )
  }

  itemsList ({ admin: isAdmin }) {
    var list = [
      {
        title: I18n.t("navbar.options.sign_out"),
        link: "/api/v1/sign_out",
        method: "DELETE",
        onClickCallback: () => window.location.reload()
      }
    ];

    if (isAdmin) {
      list.unshift({
        title: I18n.t("navbar.options.admin_panel"),
        link: "/admin_panel",
        method: "GET"
      });
    }

    return list;
  }

  render () {
    const { user } = this.props;
    const header = this.header(user);
    const itemsList = this.itemsList(user);

    return (
      <Dropdown
        header={header}
        items={itemsList}
      />
    )
  }
}

export default UserDropdown;
