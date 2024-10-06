import React from "react";
import { useNavigate } from "react-router-dom";
import { Button } from "react-bootstrap";

const ConnectWallet = () => {
    const navigate = useNavigate();
    return (
        <div>
            <h1>Connect Wallet</h1>
            <Button
                onClick={() => {
                    navigate("/wallet");
                }}
            >
                Connect Wallet
            </Button>
        </div>
    );
};

export default ConnectWallet;