import PropTypes from "prop-types";

class Pagination extends React.Component {
  constructor (props) {
    super(props);
  }

  renderPageButton (pageNumber) {
    const { activePage, onPageChange } = this.props;

    return (
      <button
        className={"btn btn-outline-secondary pagination-button " + (activePage === page ? "active" : null)}
        onClick={(_event) => onPageChange(pageNumber)}
      >
        {pageNumber}
      </button>
    )
  }

  render () {
    const { pagesNumber } = this.props;

    // do not show pagination bar, if pages count is less than 2
    if (pagesNumber < 2)
      return <div className="pagination"></div>


      ////!!!!!!////////   THIS  map  BELOW WILL NOT WORK, BECAUSE pagesNumber IS A NUMBER
    return (
      <div className="pagination">
        <button className="page-controls previous-page">
          {"<"}
        </button>
        { pagesNumber.map((pageNumber) => this.renderPageButton(pageNumber)) }
        <button className="page-controls next-page">
          {">"}
        </button>
      </div>
    )
  }
}

Pagination.propTypes = {
  pagesNumber: PropTypes.number,
  activePage: PropTypes.number,
  onPageChange: PropTypes.func
}

Pagination.defaultProps = {
  pagesNumber: 0,
  activePage: 0,
  onPageChange: (_newPage) => {}
}

export default Pagination;
