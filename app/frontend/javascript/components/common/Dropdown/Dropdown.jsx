import { Redirect } from "react-router-dom";
import PropTypes from "prop-types";
import DropdownItem from "./DropdownItem";

class Dropdown extends React.Component {
  constructor(props) {
    super(props);

    this.state = { showMenu: false }

    this.showMenu = this.showMenu.bind(this);
    this.closeMenu = this.closeMenu.bind(this);

    this.renderItems = this.renderItems.bind(this);
  }

  showMenu () {
    this.setState({ showMenu: true }, () => {
      document.addEventListener("click", this.closeMenu);
    });
  }

  closeMenu () {
    this.setState({ showMenu: false }, () => {
      document.removeEventListener("click", this.closeMenu)
    });
  }

  renderItems (items) {
    var menu = [];

    items.forEach((item, index) => {
      menu.push(
        <DropdownItem key={index} item={item} />
      )
    });

    return menu;
  }

  render () {
    const { header, items } = this.props;
    const { showMenu } = this.state;

    return (
      <div className="dropdown mr-2">
        <button
          className={"dropdown-header dropdown-toggle " + header.className}
          id={header.id}
          onClick={this.showMenu}
        >
          {header.title}
        </button>

        {
          showMenu
            ? (
              <div className="dropdown-menu show">
                {this.renderItems(items)}
              </div>
            )
            : null
        }
      </div>
    )
  }
}

Dropdown.propTypes = {
  header: PropTypes.object,
  // {
  //   title: PropTypes.string,
  //   className: PropTypes.string,
  //   id: PropTypes.string
  // },
  items: PropTypes.array
  // [{
  //   title: PropTypes.string,
  //   link: PropTypes.string,
  //   method: PropTypes.string,
  //   className: PropTypes.string,
  //   onClickCallback: PropTypes.func
  // }]
}

Dropdown.defaultProps = {
  header: {
    title: "Dropdown title",
    className: "",
    id: ""
  },
  items: [{}]
}

export default Dropdown;
