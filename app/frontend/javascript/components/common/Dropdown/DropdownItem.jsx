import fetchLink from "../../../helpers/fetchLink";
import { Link } from "react-router-dom";
import PropTypes from "prop-types";

class DropdownItem extends React.Component {
  constructor (props) {
    super(props);

    this.itemLink = this.itemLink.bind(this);
    this.itemButton = this.itemButton.bind(this);
    this.onButtonClick = this.onButtonClick.bind(this);
  }

  onButtonClick ({ link, method, onClickCallback }) {
    fetchLink({
      link: link,
      method: method,
      onSuccess: (response) => {
        if (typeof(onClickCallback) === "function")
          onClickCallback(response);
      }
    });
  }

  itemLink ({ link, className, id, title }) {
    return (
      <Link
        to={link}
        id={id}
        className={"dropdown-item " + className}
      >
        {title}
      </Link>
    )
  }

  itemButton (item) {
    const { className, id, title } = item;

    return (
      <button
        id={id}
        className={"dropdown-item " + className}
        onClick={() => this.onButtonClick(item)}
      >
        {title}
      </button>
    )
  }

  render () {
    const { item } = this.props;

    if (item.method === "GET")
      return this.itemLink(item)
    else
      return this.itemButton(item)
  }
}

DropdownItem.propTypes = {
  item: PropTypes.object
}

DropdownItem.defaultProps = {
  item: {
    link: "",
    method: "GET",
    className: "",
    id: "",
    title: "Sample item title",
    onClickCallback: undefined
  }
}

export default DropdownItem;
