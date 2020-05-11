import { Loader as LibLoader } from "react-loaders";
import PropTypes from "prop-types";





/////////////    TODO:         ADD   POSSIBILITY OF   SHOWING   OUR CUSTOM    ANIMATED   LOGO   LOADER



class Loader extends React.Component {
  render () {
    const { type, color } = this.props;

    return (
      <div id="loader">
        <LibLoader type={type} color={color} />
      </div>
    )
  }
}

Loader.propTypes = {
  type: PropTypes.string,
  color: PropTypes.string
}

Loader.defaultProps = {
  type: "line-spin-fade-loader",
  color: "#0aa1fc"
}

export default Loader;
