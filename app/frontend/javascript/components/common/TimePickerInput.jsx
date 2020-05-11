import PropTypes from "prop-types";
import { TimePicker as InlineTimePicker } from "antd";
import moment from "moment";
import FullScreenTimePicker from "pickerjs";




//      TODO:     try to refactor smh




class TimePickerInput extends React.Component {
  constructor (props) {
    super(props);

    const { initialValue } = this.props;

    this.state = {
      value: initialValue,
      mobileView: this.isMobileView()
    }

    this.isMobileView = this.isMobileView.bind(this);
    this.handleTimeInputChange = this.handleTimeInputChange.bind(this);
    this.onWindowResize = this.onWindowResize.bind(this);
    this.initializeMobilePicker = this.initializeMobilePicker.bind(this);
  }

  isMobileView = () => document.documentElement.clientWidth <= 800;

  handleTimeInputChange (_time, timeString) {
    this.props.handleInputChange({ target: { name: "eventTime", value: timeString } });
  }

  onWindowResize () {
    const isMobile = this.isMobileView();

    (isMobile != this.state.mobileView) && this.setState({ mobileView: isMobile });
  }

  initializeMobilePicker () {
    if (!this.state.mobileView)
      return

    const { value } = this.state;
    const { format } = this.props;

    new FullScreenTimePicker(document.querySelector(".js-date-picker"), {
      container: ".time-input-container",
      format,
      headers: true,
      controls: true,
      date: value
    });

    document.querySelector(".js-date-picker").addEventListener("change", this.props.handleInputChange);
  }

  componentDidMount () {
    this.initializeMobilePicker();
    window.addEventListener("resize", this.onWindowResize);
  }

  componentWillUnmount () {
    window.removeEventListener("resize", this.onWindowResize);
  }

  componentDidUpdate = this.initializeMobilePicker;

  render () {
    const { value, mobileView } = this.state;
    const { disabled = false, placeholder, format, name, invalid } = this.props;

    if (mobileView) {
      return (
        <div>
          <input
            ref={element => this.timeInput = element}
            type="text"
            defaultValue={value}
            name={name}
            className={"form-control js-date-picker"  + (invalid ? " is-invalid" : "")}
            placeholder={placeholder}
          />
          <div className="time-input-container" />
        </div>
      )
    } else
      return (
        <InlineTimePicker
          getPopupContainer={trigger => trigger}
          format={format}
          hideDisabledOptions={true}
          defaultValue={value ? moment(value, format) : ""}
          onChange={this.handleTimeInputChange}
          name={name}
          className={"form-control" + (invalid ? " is-invalid" : "")}
          placeholder={placeholder}
          disabled={disabled}
        />
      )
  }
}

TimePickerInput.propTypes = {
  handleInputChange: PropTypes.func.isRequired,
  initialValue: PropTypes.string,
  invalid: PropTypes.bool,
  disabled: PropTypes.bool,
  placeholder: PropTypes.string,
  format: PropTypes.string,
  name: PropTypes.string
}

TimePickerInput.defaultProps = {
  invalid: false,
  disabled: false,
  placeholder: "",
  format: "HH:mm",
  name: "inputTimePicker"
}

export default TimePickerInput;
