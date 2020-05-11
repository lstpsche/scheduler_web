import PropTypes from "prop-types";
import fetchLink from "../../../../helpers/fetchLink";
import { connect } from "react-redux";
import { addSchedule } from "../../../../store/actions/schedules";

class ScheduleCreateRowForm extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      scheduleName: "",
      scheduleAdditionalInfo: "",
      errors: {},
      formBlocked: false,
    }

    this.handleInputChange = this.handleInputChange.bind(this);
    this.onKeyPress = this.onKeyPress.bind(this);
    this.validateFormPresence = this.validateFormPresence.bind(this);
    this.toggleFormBlock = this.toggleFormBlock.bind(this);

    this.onCreateSuccess = this.onCreateSuccess.bind(this);
    this.onCreateError = this.onCreateError.bind(this);
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
    if (event.which === 13)
      this.handleSubmit();
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

  onCreateSuccess ({ id, name, additional_info: additionalInfo }) {
    const { addSchedule, onScheduleCreate } = this.props;

    this.setState({ scheduleName: "", scheduleAdditionalInfo: "" });
    addSchedule(id, name, additionalInfo);
    onScheduleCreate();
  }

  onCreateError (errors) {
    const { name: nameError, additional_info: addInfoError } = errors;
    this.setState({ errors: { scheduleName: nameError, additionalInfo: addInfoError } });
    this.toggleFormBlock(false);
  }

  handleSubmit () {
    if (!this.validateFormPresence())
      return

    this.toggleFormBlock(true);

    const { scheduleName: name, scheduleAdditionalInfo: additional_info } = this.state;

    fetchLink({
      link: '/api/v1/schedules',
      method: "POST",
      body: JSON.stringify({ schedule: { name, additional_info } }),
      onSuccess: ({ success, schedule, errors }) => {
        if (success)
          return this.onCreateSuccess(schedule.data.attributes);
        this.onCreateError(errors);
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
        id="new-schedule-form"
        className={"new schedule-form schedule" + (formBlocked ? " disabled-row pointer-loading" : "")}
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
            + Create
          </button>
        </td>
      </tr>
    )
  }
}

ScheduleCreateRowForm.propTypes = {
  rowRef: PropTypes.func.isRequired,
  onScheduleCreate: PropTypes.func.isRequired
}

const mapDispatchToProps = dispatch => ({
  addSchedule: (id, name, additionalInfo) => dispatch(addSchedule({ id, name, additionalInfo }))
})

export default connect(null, mapDispatchToProps)(ScheduleCreateRowForm);
