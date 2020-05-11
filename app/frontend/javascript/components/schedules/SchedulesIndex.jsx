import { connect } from "react-redux";
import { setSchedules } from "../../store/actions/schedules";
import fetchLink from "../../helpers/fetchLink";
import SchedulesTable from "./components/index/SchedulesTable";
import Pagination from "../common/Pagination";
import Loader from "../common/Loader";

class SchedulesIndex extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      tableBlocked: false,
      page: 0
    }

    this.schedulesOnPage = 5;

    this.toggleTableBlock = this.toggleTableBlock.bind(this);
    this.onPageChange = this.onPageChange.bind(this);
    this.schedulesOnPageRange = this.schedulesOnPageRange.bind(this);
    this.pagesNumber = this.pagesNumber.bind(this);
  }

  async toggleTableBlock (state) {
    this.setState({ tableBlocked: state });
  }

  onPageChange (newPage) {
    this.setState({ page: newPage });
  }

  pagesNumber () {
    const { schedules: { length: schedulesCount  } } = this.props;

    // count all pages number depending on schedules count
    return Math.ceil(schedulesCount / this.schedulesOnPage) || 1;
  }

  schedulesOnPageRange () {
    var { page } = this.state;

    // set page to the last available, if it's out of bounds (just in case)
    page = (page > this.pagesNumber() - 1) ? this.pagesNumber() - 1 : page;

    const start = page * this.schedulesOnPage;
    const end = (page + 1) * this.schedulesOnPage;

    return [start, end]
  }

  componentDidMount () {
    this.toggleTableBlock(true);

    fetchLink({
      link: "/api/v1/schedules",
      onSuccess: (response) => {
        this.props.setSchedules(
          response.schedules.map(({ data: { attributes: { id, name, additional_info: additionalInfo }}}) => (
            { id, name, additionalInfo }
          ))
        );
        this.toggleTableBlock(false);
      },
      onFailure: (error) => {
        this.toggleTableBlock(false);
        throw new Error(error);
      }
    });
  }

  render () {
    const { tableBlocked, page } = this.state;
    var { schedules } = this.props;

    // get only schedules from set page
    schedules = schedules.slice(...this.schedulesOnPageRange());
    const schedulesIds = schedules.map(schedule => schedule.id)

    return (
      <div className="container schedules">
        <h1 className="my-4 text-center">
          {I18n.t("schedules.all_schedules")}
        </h1>

        <BlockUi tag="div" blocking={tableBlocked} loader={<Loader />} keepInView>
          <SchedulesTable schedulesIds={schedulesIds} />
        </BlockUi>
        <Pagination pagesNumber={this.pagesNumber()} schedulesIdsactivePage={page} onPageChange={this.onPageChange} />
      </div>
    )
  }
}

const mapStateToProps = state => ({ schedules: state.schedules });

const mapDispatchToProps = dispatch => ({
  setSchedules: (schedules) => dispatch(setSchedules(schedules))
});

export default connect(mapStateToProps, mapDispatchToProps)(SchedulesIndex);
