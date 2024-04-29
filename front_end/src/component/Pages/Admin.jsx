import RegisterStudent from "../Services/AdminServices/RegisterStudent"; // Assuming path
import CardsA from "../Admin/CardsA";
import WelcomeA from "../Admin/WelcomeA";
import { useState } from "react";
import RegisterProfessor from "../Services/AdminServices/RegisterProfessor";
import RegisterEmploye from "../Services/AdminServices/RegisterEmploye";

const Admin = () => {
  const [showRegisterForm, setShowRegisterForm] = useState(false);
  const handleRegisterClick = () => {
    setShowRegisterForm(true);
  };
  const [showRegisterprof, setShowRegisterprof] = useState(false);
  const handleRegisterprof = () => {
    setShowRegisterprof(true);
  };
  const [RegisterEmp, setRegisterEmp] = useState(false);
  const handleRegisterEmp = () => {
    setRegisterEmp(true);
  };

  return (
    <>
      <WelcomeA />
      <button onClick={handleRegisterClick}>Register Student</button>
      {showRegisterForm && <RegisterStudent />}

      <button onClick={handleRegisterprof}>RegisterProfessor</button>
      {showRegisterprof && <RegisterProfessor />}

      <button onClick={handleRegisterEmp}>RegisterEmploye</button>
      {RegisterEmp && <RegisterEmploye />}

      <CardsA />
    </>
  );
};

export default Admin;
