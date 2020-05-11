import PropTypes from "prop-types";
import { connect } from "react-redux";
import { updateEvent } from "../../../../store/actions/events";
import TimePickerInput from "../../../common/TimePickerInput";
import fetchLink from "../../../../helpers/fetchLink";

class EventEditRowForm extends React.Component {
  constructor (props) {
    super(props);

    const { time: eventTime, info: eventInfo, additionalInfo: eventAdditionalInfo } = this.props.event;

    this.initialValues = { initialTime: eventTime, initialInfo: eventInfo, initialAdditionalInfo: eventAdditionalInfo };

    this.state = {
      eventTime, eventInfo, eventAdditionalInfo,
      errors: {},
      formBlocked: false
    }

    this.hideRowForm = this.hideRowForm.bind(this);

    this.handleInputChange = this.handleInputChange.bind(this);
    this.onKeyPress = this.onKeyPress.bind(this);
    this.validateFormPresence = this.validateFormPresence.bind(this);
    this.toggleFormBlock = this.toggleFormBlock.bind(this);

    this.onUpdateSuccess = this.onUpdateSuccess.bind(this);
    this.onUpdateFailure = this.onUpdateFailure.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
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

  compareWithInitial () {
    const { eventTime, eventInfo, eventAdditionalInfo } = this.state;
    const { initialTime, initialInfo, initialAdditionalInfo } = this.initialValues;

    return (
      eventTime == initialTime &&
      eventInfo == initialInfo &&
      eventAdditionalInfo == initialAdditionalInfo
    )
  }

  onUpdateSuccess (event) {
    const { schedule_id: scheduleId, id, time, weekday, info, additional_info: additionalInfo } = event.data.attributes;
    const { updateEvent } = this.props;

    updateEvent(scheduleId, { id, time, weekday, info, additionalInfo });
    this.hideRowForm();
  }

  onUpdateFailure (errors) {
    const { time: timeError, info: infoError, additional_info: addInfoError } = errors;
    this.setState({ errors: { eventTime: timeError, eventInfo: infoError, eventAdditionalInfo: addInfoError } });
    this.toggleFormBlock(false);
  }

  handleSubmit () {
    if (!this.validateFormPresence())
      return

    if (this.compareWithInitial())
      return this.hideRowForm();

    this.toggleFormBlock(true);

    const { id: eventId, scheduleId } = this.props.event;
    const { eventTime: time, eventInfo: info, eventAdditionalInfo: additional_info } = this.state;

    fetchLink({
      link: "/api/v1/schedules/" + scheduleId + "/events/" + eventId,
      method: "PUT",
      body: JSON.stringify({ event: { time, info, additional_info } }),
      onSuccess: ({ success, event, errors }) => {
        if (success)
          return this.onUpdateSuccess(event);
        this.onUpdateFailure(errors);
      }
    });
  }

  hideRowForm (event) {
    if (event == undefined || !this.formRow.contains(event.target)) {
      document.removeEventListener("click", this.hideRowForm)
      this.props.hideRowForm();
    }
  }

  componentDidMount () {
    this.eventInfoInput.focus();
    document.addEventListener("click", this.hideRowForm);
  }


  ////////    TODO:     ATTEMPT TO CREATE A UNIQUE Input COMPONENT




  render () {
    const { formBlocked, eventTime, eventInfo, eventAdditionalInfo, errors } = this.state;

    return (
      <tr
        className={"edit event" + (formBlocked ? " disabled-row pointer-loading" : "")}
        ref={element => this.formRow = element}
      >
        <td className="time">
          <TimePickerInput
            name="eventTime"
            initialValue={eventTime}
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
            Save
          </button>
        </td>
      </tr>
    )
  }
}

EventEditRowForm.propTypes = {
  event: PropTypes.object.isRequired,
  hideRowForm: PropTypes.func.isRequired
}

const mapDispatchToProps = dispatch => ({
  updateEvent: (scheduleId, event) => dispatch(updateEvent({ scheduleId, ...event }))
})

export default connect(null, mapDispatchToProps)(EventEditRowForm);
