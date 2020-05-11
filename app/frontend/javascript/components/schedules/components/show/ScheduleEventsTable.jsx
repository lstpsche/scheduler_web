import PropTypes from "prop-types";
import ScheduleEventsWeekdayTable from "./ScheduleEventsWeekdayTable";

class ScheduleEventsTable extends React.Component {
  constructor (props) {
    super(props);

    this.sortEventsByWeekday = this.sortEventsByWeekday.bind(this);
  }

  sortEventsByWeekday (events) {
    // event: {
    //   weekday: {
    //     event,
    //     event
    //   }
    // }
    ////////  TODO:  refactor or find another way
    var sortedEvents = { monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: [], sunday: []};




    ///////   TODO:     WE NEED TO SORT EVENTS WITH THE SAME TIME

    //////    IDEA №1:
    ////////  Introduce new Event field  ---  position
    ////////  It will show Event position in its weekday table
    ////////  This makes Drag'n'Drop logic easier, saves state
    ////////
    ////////  Firstly, sort events by positions
    ////////  Then by weekdays
    ////////  So there's no need for fake date assignment (look at ScheduleShow)




    for (const index in events) {
      const event = events[index];
      sortedEvents[event.weekday].push(event);
    }

    return sortedEvents;
  }

  render () {
    const { events, scheduleId } = this.props;
    const sortedEvents = this.sortEventsByWeekday(events);

    return (
      <table
        className="table table-sm"
      >
        <tbody>
        {
          _.keys(sortedEvents).map(
            (weekday, index) => ([
              <tr className="weekday" key={index + "-weekday-title-row"}>
                <th key={index + "-weekday-title-th"}>
                  {weekday[0].toUpperCase() + weekday.slice(1)}
                </th>
              </tr>,
              <tr className="weekday-events" key={index + "-weekday-events-row"}>
                <td key={index + "-weekday-events-td"}>
                  <ScheduleEventsWeekdayTable
                    key={index + "-weekday-events-table"}
                    weekday={weekday}
                    scheduleId={scheduleId}
                    events={sortedEvents[weekday]}
                  />
                </td>
              </tr>
            ])
          )
        }
        </tbody>
      </table>
    )
  }
}

ScheduleEventsTable.propTypes = {
  events: PropTypes.array.isRequired,
  scheduleId: PropTypes.number.isRequired
}

export default ScheduleEventsTable;
