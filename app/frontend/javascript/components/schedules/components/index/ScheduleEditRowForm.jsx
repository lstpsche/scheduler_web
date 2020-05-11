import fetchLink from "../../../../helpers/fetchLink";
import PropTypes from "prop-types";
import { connect } from "react-redux";
import { updateSchedule } from "../../../../store/actions/schedules";

class ScheduleEditRowForm extends React.Component {
  constructor (props) {
    super(props);

    const { name: scheduleName, additionalInfo: scheduleAdditionalInfo } = this.props.schedule;

    this.state = {
      scheduleName, scheduleAdditionalInfo,
      errors: {},
      formBlocked: false,
    };

    this.handleInputChange = this.handleInputChange.bind(this);
    this.onKeyPress = this.onKeyPress.bind(this);
    this.validateFormPresence = this.validateFormPresence.bind(this);
    this.toggleFormBlock = this.toggleFormBlock.bind(this);

    this.onUpdateSuccess = this.onUpdateSuccess.bind(this);
    this.onUpdateError = this.onUpdateError.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleInputChange (event) {
    const { name, value } = event.target;

    this.setState({ [name]: value, errors: { [name]: undefined } });
  }

  onKeyPress (event) {
    if (event.which === 13) {
      this.handleSubmit();
    }
  }

  validateFormPresence () {
    const { scheduleName } = this.state;
    var errors = {};

    if (!scheduleName.length) {
      errors.scheduleName = "can't be blank";
    }

    this.setState({ errors });

    return _.isEmpty(errors)
  }

  toggleFormBlock (state) {
    this.setState({ formBlocked: state });
  }

  onUpdateSuccess (schedule) {
    const { id, name, additional_info: additionalInfo } = schedule.data.attributes;
    const { updateSchedule, onScheduleUpdate } = this.props;

    updateSchedule({ id, name, additionalInfo });
    onScheduleUpdate();
  }

  onUpdateError (errors) {
    const { name: nameError, additional_info: addInfoError } = errors;
    this.setState({ errors: { scheduleName: nameError, scheduleAdditionalInfo: addInfoError } });
    this.toggleFormBlock(false);
  }

  handleSubmit () {
    if (!this.validateFormPresence())
      return

    this.toggleFormBlock(true);

    const { id: scheduleId } = this.props.schedule;
    const { scheduleName: name, scheduleAdditionalInfo: additional_info } = this.state;

    fetchLink({
      link: "/api/v1/schedules/" + scheduleId,
      method: "PUT",
      body: JSON.stringify({ schedule: { name, additional_info } }),
      onSuccess: ({ success, schedule, errors}) => {
        if (success)
          return this.onUpdateSuccess(schedule);
        this.onUpdateError(errors);
      }
    });
  }

  componentDidMount () {
    this.scheduleNameInput.focus();
  }

  render () {
    const { rowRef } = this.props;
    const { scheduleName, scheduleAdditionalInfo, errors, formBlocked } = this.state;

    return (
      <tr
        className={"edit schedule" + (formBlocked ? " disabled-row pointer-loading" : "")}
        ref={rowRef}
      >
        <td className="name">
          <input
            ref={element => this.scheduleNameInput = element}
            type="text"
            name="scheduleName"
            className={"form-control" + (errors.scheduleName ? " is-invalid" : "")}
            placeholder={I18n.t("schedules.schedule_name")}
            value={scheduleName}
            onChange={this.handleInputChange}
            onKeyPress={this.onKeyPress}
            disabled={formBlocked}
          />
        </td>
        <td className="add-info">
          <input
            type="text"
            name="scheduleAdditionalInfo"
            className={"form-control" + (errors.scheduleAdditionalInfo ? " is-invalid" : "")}
            placeholder={I18n.t("schedules.additional_info")}
            value={scheduleAdditionalInfo}
            onChange={this.handleInputChange}
            onKeyPress={this.onKeyPress}
            disabled={formBlocked}
          />
        </td>
        <td className="schedule-actions col-2">
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

ScheduleEditRowForm.propTypes = {
  scheduleId: PropTypes.number.isRequired,
  onScheduleUpdate: PropTypes.func.isRequired,
  rowRef: PropTypes.func.isRequired
}

const mapStateToProps = (state, ownProps) => {
  const schedule = state.schedules.filter(({ id }) => ownProps.scheduleId === id)[0]

  return { schedule };
}

const mapDispatchToProps = dispatch => ({
  updateSchedule: (schedule) => dispatch(updateSchedule(schedule))
});

export default connect(mapStateToProps, mapDispatchToProps)(ScheduleEditRowForm);
