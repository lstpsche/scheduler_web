import PropTypes from "prop-types";
import EventCreateRowForm from "./EventCreateRowForm";

class EventCreateRow extends React.Component {
  constructor (props) {
    super(props);

    this.state = { showForm: false };

    this.showFormRow = this.showFormRow.bind(this);
    this.hideFormRow = this.hideFormRow.bind(this);
    this.onEventCreate = this.onEventCreate.bind(this);
  }

  showFormRow () {
    this.setState({ showForm: true }, () => {
      document.addEventListener("click", this.hideFormRow);
    });
  }

  hideFormRow (event) {
    if (event === undefined || !this.formRow.contains(event.target))
      this.setState({ showForm: false }, () => {
        document.removeEventListener("click", this.hideFormRow);
      });
  }

  onEventCreate () {
    this.hideFormRow();
  }

  render () {
    const { showForm } = this.state;
    const { weekday, scheduleId } = this.props;

    if (showForm)
      return (
        <EventCreateRowForm
          rowRef={element => this.formRow = element}
          onEventCreate={this.onEventCreate}
          weekday={weekday}
          scheduleId={scheduleId}
        />
      )
    else
      return (
        <tr
          id={weekday + "-new-event-row"}
          className="event new event-form event-actions"
          onClick={this.showFormRow}
        >
          <td colSpan="3">
            <button
              id={weekday + "-new-event-button"}
              className="btn btn-outline-secondary new event-button"
            >
              + Create event
            </button>
          </td>
        </tr>
      )
  }
}

EventCreateRow.propTypes = {
  weekday: PropTypes.string.isRequired,
  scheduleId: PropTypes.number.isRequired
}

export default EventCreateRow;
