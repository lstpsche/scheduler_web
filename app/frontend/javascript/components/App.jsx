import { BrowserRouter, Route, Switch, Redirect } from "react-router-dom";
import fetchLink from "../helpers/fetchLink";
import UserContext from "./contexts/UserContext";
import NotFound from "./errors/NotFound";
import Navbar from "./Navbar";
import Home from "../components/Home";
import AdminPanel from "./admin/AdminPanel";
import SchedulesIndex from "./schedules/SchedulesIndex";
import ScheduleShow from "./schedules/ScheduleShow";
import Loader from "../components/common/Loader";

class App extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      signedIn: undefined,
      user: {}
    }

    this.removeTrailingSlashes = this.removeTrailingSlashes.bind(this);
  }

  componentDidMount () {
    fetchLink({
      link: "/api/v1/auth/signed_in",
      onSuccess: ({ signed_in: signedIn, user = { data: { attributes: {} }} }) => {
        this.setState({
          signedIn: signedIn,
          user: user.data.attributes
        });
      },
      errorMessage: "Not logged in."
      // TODO: Add alertify call from onFailure: () => {...}
    });
  }

  removeTrailingSlashes () {
    return (
      <Route path="/:url*(/+)" exact strict render={({ location }) => (
          <Redirect to={location.pathname.replace(/\/+$/, "")} />
        )}
      />
    )
  }

  render () {
    const { signedIn, user } = this.state;
    user.signedIn = signedIn;

    // TODO: return here beautiful loader (<Loader />), so that it will be shown before rendering app
    // first version -- just simple loader
    // better version -- logo animation smh
    if (signedIn === undefined)
      return <BlockUi tag="div" id="full-page-cover" blocking={true} loader={<Loader />} keepInView/>

    return (
      <BrowserRouter>
        <UserContext.Provider value={user}>
          <Navbar />
          <div className="container col-lg-7 col-md-10 col-sm-11 col-xs-auto">
            {
              signedIn
              ? (
                <Switch>
                  { this.removeTrailingSlashes() }
                  <Route path="/" exact component={SchedulesIndex} />
                  <Route path="/schedules" exact component={SchedulesIndex} />
                  <Route path="/schedules/:scheduleId" exact component={ScheduleShow} />
                  <Route path="/admin_panel" exact component={AdminPanel} />
                  <Route path="/admin_panel/users_table" exact
                    render={(props) => <AdminPanel {...props} activeTab={"users_table_tab"} />}
                  />
                  <Route path="/" component={NotFound} />
                </Switch>
              )
              : (
                <Switch>
                  <Route path="/" exact component={Home} />

                  <Route path="/" render={() => (
                      <Redirect to="/" />
                    )}
                  />
                </Switch>
              )
            }
          </div>
        </UserContext.Provider>
      </BrowserRouter>
    )
  }
};

export default App;
