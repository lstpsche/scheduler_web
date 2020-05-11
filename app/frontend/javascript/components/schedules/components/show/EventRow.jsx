import PropTypes from "prop-types";
import { connect } from "react-redux";
import EventEditRowForm from "./EventEditRowForm";
import fetchLink from "../../../../helpers/fetchLink";
import { removeEvent } from "../../../../store/actions/events";

class EventRow extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      showForm: false
    };

    this.onEventDelete = this.onEventDelete.bind(this);
    this.showRowForm = this.showRowForm.bind(this);
    this.hideRowForm = this.hideRowForm.bind(this);
  }

  onEventDelete () {
    const { removeEvent, event: { scheduleId, id } } = this.props;

    fetchLink ({
      link: "/api/v1/schedules/" + scheduleId + "/events/" + id,
      method: "DELETE",
      // TODO: investigate the ways to show animation of removal
      // example:  make red background, and animate tr height from default to 0, then trigger remove event
      onSuccess: () => removeEvent({ scheduleId, id }),
      onFailure: (error) => { throw new Error(error) }
    })
  }

  showRowForm () {
    this.setState({ showForm: true });
  }

  hideRowForm () {
    this.setState({ showForm: false });
  }

  render () {
    const eventObject = this.props.event;
    const { time, info, additionalInfo } = eventObject;
    const { showForm } = this.state;

    if (showForm)
      return (
        <EventEditRowForm
          event={eventObject}
          hideRowForm={this.hideRowForm}
        />
      )
    else
      return (
        <tr className="event event-row">
          <th className="time">{time}</th>
          <td className="info" colSpan="2">
            {info} <em>({additionalInfo})</em>
          </td>
          <td className="event-actions">
            <button
              className="btn btn-outline-secondary"
              onClick={this.onEventDelete}
            >
              X
            </button>
            <button
              className="btn btn-outline-secondary edit event-button"
              onClick={this.showRowForm}
            >
              E
            </button>
          </td>
        </tr>
      )
  }
}

EventRow.propTypes = {
  event: PropTypes.object.isRequired
}

EventRow.defaultProps = {
  additionalInfo: ""
}

const mapDispatchToProps = (dispatch) => {
  return {
    removeEvent: (event) => dispatch(removeEvent(event))
  }
}

export default connect(null, mapDispatchToProps)(EventRow);
