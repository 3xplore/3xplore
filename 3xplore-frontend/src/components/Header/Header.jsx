import React from "react";
import logo from "/images/LogoText@3x1.png";
import "./Header.css";

export const Navbar = () => {
    return (
        <div className="navbar">
            <div className="navbar-container">
                <div className="navbar-logo">
                    <a href="/"><img src={logo} alt="logo" /></a>                    <div className="navs">
                        <a href="/">Base Bytes</a>
                        <a href="/">Docs</a>
                    </div>
                </div>
                <div className="signin-btn">
                    <button>Sign In</button>
                </div>
            </div>
        </div>
    );
};
export default Navbar;
