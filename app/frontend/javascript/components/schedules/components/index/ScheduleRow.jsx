import PropTypes from "prop-types";
import { connect } from "react-redux";
import ScheduleEditRowForm from "./ScheduleEditRowForm";
import { Redirect } from "react-router-dom";

class ScheduleRow extends React.Component {
  constructor (props) {
    super(props);

    const { name, additionalInfo } = this.props;

    this.state = {
      redirectTo: undefined,
      showForm: false,
      name, additionalInfo
    };

    this.showRowForm = this.showRowForm.bind(this);
    this.hideRowForm = this.hideRowForm.bind(this);
    this.onRowClick = this.onRowClick.bind(this);
    this.onScheduleUpdate = this.onScheduleUpdate.bind(this);
  }

  showRowForm () {
    this.setState({ showForm: true }, () => {
      document.addEventListener("click", this.hideRowForm);
    });
  }

  hideRowForm (event) {
    // func can be triggered separately or via onClick callback
    if (event === undefined || !this.formRow.contains(event.target))
      this.setState({ showForm: false }, () => {
        document.removeEventListener("click", this.hideRowForm);
      });
  }

  onScheduleUpdate () {
    this.hideRowForm();
  }

  onRowClick (event) {
    if (event.target.classList.contains("schedule-button"))
      return

    this.setState({ redirectTo: "/schedules/" + this.props.id })
  }

  render () {
    const { redirectTo, showForm } = this.state;
    const { id, name, additionalInfo } = this.props;

    if (redirectTo)
      return <Redirect to={redirectTo} />

    if (showForm)
      return (
        <ScheduleEditRowForm
          rowRef={element => this.formRow = element}
          scheduleId={id}
          onScheduleUpdate={this.onScheduleUpdate}
        />
      )
    else
      //////////
      /////////////      TODO:    Probably, will need to replace simple text with inputs without background and borders
      //////////
      return (
        <tr className="schedule-row" onClick={this.onRowClick}>
          <td className="name">{name}</td>
          <td className="add-info">{additionalInfo}</td>
          <td className="schedule-actions">
            <button
              className="btn btn-outline-secondary edit schedule-button"
              onClick={this.showRowForm}
            >
              Edit
            </button>
          </td>
        </tr>
      )
  }
}

ScheduleRow.propTypes = {
  scheduleId: PropTypes.number.isRequired
}

const mapStateToProps = (state, ownProps) => {
  const { scheduleId } = ownProps;
  const { name, additionalInfo } = state.schedules.find(({ id }) => id === scheduleId);

  return { id: scheduleId, name, additionalInfo };
}

export default connect(mapStateToProps)(ScheduleRow);
