import ScheduleCreateRowForm from "./ScheduleCreateRowForm";

class ScheduleCreateRow extends React.Component {
  constructor (props) {
    super(props);

    this.state = { showForm: false };

    this.showFormRow = this.showFormRow.bind(this);
    this.hideFormRow = this.hideFormRow.bind(this);
    this.onScheduleCreate = this.onScheduleCreate.bind(this);
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

  onScheduleCreate () {
    this.hideFormRow();
  }

  render () {
    const { showForm } = this.state;

    if (showForm)
      return (
        <ScheduleCreateRowForm
          rowRef={element => this.formRow = element}
          onScheduleCreate={this.onScheduleCreate}
        />
      )
    else
      return (
        <tr
          id="new-schedule-row"
          className="schedule new schedule-form schedule-actions"
          onClick={this.showFormRow}
        >
          <td colSpan="3">
            <button
              id="new-schedule-button"
              className="btn btn-outline-secondary new schedule-button"
            >
              + Create schedule
            </button>
          </td>
        </tr>
      )
  }
}

export default ScheduleCreateRow;
