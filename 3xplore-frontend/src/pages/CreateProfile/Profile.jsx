import React from "react";
import "./Profile.css";
import baselogo from "/images/coinbase.png";
import { Button } from "react-bootstrap";

export const CreateProfile = () => {
    return (
        <div className="row no-gutters">
            <div className="create-proflie-img col-md-6 no-gutters">
                <h1 className="txt">
                    Elevate Your <br /> Blockchain IQ
                </h1>
            </div>
            <div className="connect-wallet-container col-md-6 no-gutters">
                <div className="con-wall">
                    <h4>Connect Your Wallet</h4>
                    <div className="card">
                        <div className="connect-wallet">
                            <img src={baselogo} alt="Base" />
                            <button className="btn">Coinbase</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default CreateProfile;