import { useState } from "react";
import reactLogo from "./assets/react.svg";
import Logo from "/logo.svg";
import "./App.css";
import "bootstrap/dist/css/bootstrap.min.css";
import Button from "react-bootstrap/Button";
import "bootstrap/dist/css/bootstrap.min.css";

function App() {
  return (
    <div className="App">
      <div className="main-container">
        <div className="search-container">
          <img src="logo.png" alt="Logo" className="logo" />
          <input type="text" placeholder="Search..." className="search-input" />
          <button className="wallet-button">Connect Your Wallet</button>
        </div>
        <div className="Welcome">
          <h1>Hey there!</h1>
          <h1>Welcome to 3xplore</h1>
          <h2>Fronend is cooking!</h2>
          <Button>Omo, Come Back Soon</Button>
        </div>
      </div>
    </div>
  );
}

export default App;
