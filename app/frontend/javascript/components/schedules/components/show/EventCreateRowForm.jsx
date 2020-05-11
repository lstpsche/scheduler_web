import PropTypes from "prop-types";
import { connect } from "react-redux";
import { addEvent } from "../../../../store/actions/events";
import TimePickerInput from "../../../common/TimePickerInput";
import fetchLink from "../../../../helpers/fetchLink";

class EventCreateRowForm extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      eventTime: "",
      eventInfo: "",
      eventAdditionalInfo: "",
      errors: {},
      formBlocked: false
    };

    this.handleInputChange = this.handleInputChange.bind(this);
    this.toggleFormBlock = this.toggleFormBlock.bind(this);

    this.onKeyPress = this.onKeyPress.bind(this);
    this.validateFormPresence = this.validateFormPresence.bind(this);
  }

  handleInputChange (event) {
    const { name, value } = event.target;

    this.setState({
      [name]: value,
      errors: { [name]: undefined }
    });
  }

  onKeyPress (event) {
    if (event.which === 13) {
      this.handleSubmit();
    }
  }

  validateFormPresence () {
    const { eventTime, eventInfo } = this.state;
    var errors = {};

    _.mapObject({ eventTime, eventInfo }, (value, fieldName) => {
      if (!value.length)
        errors[fieldName] = I18n.t("errors.cant_be_blank");
    })

    this.setState({ errors });

    return _.isEmpty(errors)
  }

  toggleFormBlock (state) {
    this.setState({ formBlocked: state });
  }

  onCreateSuccess (event) {
    const { schedule_id: scheduleId, id, time, weekday, info, additional_info: additionalInfo } = event.data.attributes;
    const { addEvent } = this.props;

    addEvent(scheduleId, { id, time, weekday, info, additionalInfo });
  }

  onCreateFailure (errors) {
    const { time: timeError, info: infoError, additional_info: addInfoError } = errors;
    this.setState({ errors: { eventTime: timeError, eventInfo: infoError, eventAdditionalInfo: addInfoError } });
    this.toggleFormBlock(false);
  }

  handleSubmit () {
    if (!this.validateFormPresence())
      return

    this.toggleFormBlock(true);

    const { scheduleId } = this.props;
    const { eventTime: time, eventInfo: info, eventAdditionalInfo: additional_info } = this.state;

    fetchLink({
      link: "/api/v1/schedules/" + scheduleId + "/events",
      method: "POST",
      body: JSON.stringify({ event: { time, info, additional_info } }),
      onSuccess: ({ success, event, errors }) => {
        if (success)
          return this.onCreateSuccess(event);
        this.onCreateFailure(errors);
      }
    });
  }

  componentDidMount () {

    ////   TODO:       FOCUS  TIME PICKER

    this.eventInfoInput.focus();
  }

  render () {
    const { rowRef } = this.props;
    const { eventInfo, eventAdditionalInfo, errors, formBlocked } = this.state;

    return (
      <tr
        id="new-event-form"
        className={"new event-form event" + (formBlocked ? " disabled-row pointer-loading" : "")}
        ref={rowRef}
      >
        <td className="time">
          <TimePickerInput
            name="eventTime"
            invalid={!!errors.eventTime}
            placeholder={I18n.t("events.placeholders.time")}
            handleInputChange={this.handleInputChange}
            disabled={formBlocked}
          />
        </td>
        <td className="info">
          <input
            ref={element => this.eventInfoInput = element}
            type="text"
            name="eventInfo"
            className={"form-control" + (errors.eventInfo ? " is-invalid" : "")}
            placeholder={I18n.t("events.placeholders.info")}
            value={eventInfo}
            onChange={this.handleInputChange}
            onKeyPress={this.onKeyPress}
            disabled={formBlocked}
          />
        </td>
        <td className="additionalInfo">
          <input
            type="text"
            name="eventAdditionalInfo"
            className={"form-control" + (errors.eventAdditionalInfo ? " is-invalid" : "")}
            placeholder={I18n.t("events.placeholders.additional_info")}
            value={eventAdditionalInfo}
            onChange={this.handleInputChange}
            onKeyPress={this.onKeyPress}
            disabled={formBlocked}
          />
        </td>
        <td className="event-actions">
          <button
            className={"btn btn-outline-secondary mb-2" + (formBlocked ? " disabled" : "")}
            onClick={this.handleSubmit}
          >
            Create
          </button>
        </td>
      </tr>
    )
  }
}

EventCreateRowForm.propTypes = {
  rowRef: PropTypes.func.isRequired,
  onEventCreate: PropTypes.func.isRequired,
  weekday: PropTypes.string.isRequired,
  scheduleId: PropTypes.number.isRequired
}

const mapDispatchToProps = dispatch => ({
  addEvent: (scheduleId, event) => dispatch(addEvent({ scheduleId, ...event }))
});

export default connect(null, mapDispatchToProps)(EventCreateRowForm);
