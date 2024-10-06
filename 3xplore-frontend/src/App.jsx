
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/css/bootstrap.min.css";
import "./App.css";
import { LandingPage } from "./pages/LandingPage/Home";
import { Navbar } from "./components/Header/Header";
import { CreateProfile } from "./pages/CreateProfile/Profile"; //CreateProfile from "./pages/CreateProfile/Profile";

function App() {
  return (
    <div className="App">
      {/* <Navbar /> */}
      {/* <LandingPage /> */}
      <CreateProfile />
    </div>
  );
}

export default App;
