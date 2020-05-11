import { connect } from "react-redux";
import { setEvents } from "../../store/actions/events";
import { addSchedule, updateSchedule } from "../../store/actions/schedules";
import fetchLink from "../../helpers/fetchLink";
import ScheduleEventsTable from "./components/show/ScheduleEventsTable";
import Loader from "../common/Loader";

class ScheduleShow extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      pageBlocked: true
    }

    this.addOrUpdateSchedule = this.addOrUpdateSchedule.bind(this);
    this.togglePageBlock = this.togglePageBlock.bind(this);

    this.sortEventsByTime = this.sortEventsByTime.bind(this);
  }

  togglePageBlock (state) {
    this.setState({ pageBlocked: state });
  }

  addOrUpdateSchedule (newSchedule) {
    const { schedule, updateSchedule, addSchedule } = this.props;

    schedule ? updateSchedule(newSchedule) : addSchedule(newSchedule)
  }

  sortEventsByTime (events) {
    /////////
    /////////
    //////////

    ////////
    /////////   TODO:     REPLACE WITH SOMETHING !!!!!
    /////////

    ////////////
    ///////////    I don't like this fake date assignment
    /////////

    const getDate = (time) => Date.parse('1 Jan 1970 ' + time);

    return events.sort((a, b) => getDate(a.time) - getDate(b.time));
  }

  componentDidMount () {
    const { schedule: { id: scheduleId } } = this.props;

    fetchLink({
      link: "/api/v1/schedules/" + scheduleId,
      onSuccess: (response) => {
        const { setEvents } = this.props;

        setEvents(
          response.events.map(({ data: { attributes: { schedule_id: scheduleId, id, weekday, time, info, additional_info: additionalInfo }}}) =>
            ({ scheduleId, id, weekday, time, info, additionalInfo })
          )
        )

        const { id, name, additional_info: additionalInfo } = response.schedule.data.attributes;
        this.addOrUpdateSchedule({id, name, additionalInfo});
        this.togglePageBlock(false);
      },
      onFailure: (error) => {
        //  TODO:      SHOW  ERROR  MESSAGE   AND   REDIRECT TO SchedulesIndex  ON "OK" CLICK
        throw new Error(error);
      }
    });
  }

  render () {
    const { schedule, events } = this.props;
    const { pageBlocked } = this.state;

    ////////       TODO:        SHOW HERE CUSTOM   ANIMATED   LOGO   LOADER   INSTEAD OF USUAL
    if (!schedule || pageBlocked)
      return (
        <BlockUi blocking={true}
          tag="div" id="full-page-cover"
          loader={<Loader />}
          message={<div id="loader-message">{I18n.t("schedules.show.loader_message")}</div>} keepInView
        />
      )

    return (
      <div className="schedule-view-page">
        <h2 className="schedule-title">{schedule.name}</h2>
        <button id="edit-schedule-events" className="btn btn-outline-secondary">
          Edit all events
        </button>
        <p>{schedule.additionalInfo}</p>
        <div className="schedule-events">
          <ScheduleEventsTable scheduleId={schedule.id} events={this.sortEventsByTime(events)}/>
        </div>
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  const scheduleId = parseInt(ownProps.match.params.scheduleId);

  return {
    schedule: state.schedules.filter(({ id }) => id === scheduleId)[0],
    events: state.events[scheduleId] || []
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  const scheduleId = parseInt(ownProps.match.params.scheduleId);

  return {
    setEvents: (events) => dispatch(setEvents({ scheduleId, events })),
    addSchedule: (schedule) => dispatch(addSchedule(schedule)),
    updateSchedule: (schedule) => dispatch(updateSchedule(schedule))
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(ScheduleShow);
