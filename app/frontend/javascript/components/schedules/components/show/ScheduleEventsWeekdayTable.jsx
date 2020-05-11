import PropTypes from "prop-types";
import EventRow from "./EventRow";
import EventCreateRow from "./EventCreateRow";

class ScheduleEventsWeekdayTable extends React.Component {
  constructor (props) {
    super(props);
  }

  render () {
    const { events, weekday, scheduleId } = this.props;

    return (
      <table className="table table-borderless">
        <tbody>
          {
            events.length
              ? (
                  events.map(event => (
                    <EventRow key={event.id + "-event-row"} event={event} />
                  ))
              )
              : (
                <tr>
                  <td>
                    No events here yet
                  </td>
                </tr>
              )
          }
          <EventCreateRow
            weekday={weekday}
            scheduleId={scheduleId}
          />
        </tbody>
      </table>
    )
  }
}

ScheduleEventsWeekdayTable.propTypes = {
  events: PropTypes.array.isRequired,
  weekday: PropTypes.string.isRequired,
  scheduleId: PropTypes.number.isRequired
}

export default ScheduleEventsWeekdayTable;
