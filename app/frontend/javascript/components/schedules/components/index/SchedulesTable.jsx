import PropTypes from "prop-types";
import ScheduleRow from "./ScheduleRow";
import ScheduleCreateRow from "./ScheduleCreateRow";

class SchedulesTable extends React.Component {
  constructor (props) {
    super(props);

    this.renderScheduleRow = this.renderScheduleRow.bind(this);
  }

  renderScheduleRow (id) {
    return <ScheduleRow key={id + "-schedule-row"} scheduleId={id} />
  }

  render () {
    const { schedulesIds } = this.props;

    return (
      <div className="schedules-listing">
        <table className="table table-hover schedules-table">
          <thead className="thead-light">
            <tr>
              <th className="name">{I18n.t("schedules.listing.schedule_name")}</th>
              <th className="add-info">{I18n.t("schedules.listing.additional_info")}</th>
              <th className="schedule-actions"></th>
            </tr>
          </thead>
          <tbody id="schedules-listing">
            { schedulesIds.map(this.renderScheduleRow) }

            <ScheduleCreateRow />
          </tbody>
        </table>
      </div>
    )
  }
}

SchedulesTable.propTypes = {
  schedulesIds: PropTypes.array
}

SchedulesTable.defaultProps = {
  schedulesIds: []
}

export default SchedulesTable;
