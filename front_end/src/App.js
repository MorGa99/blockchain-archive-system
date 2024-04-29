import web3, { Web3, eth } from "web3";
import spu from "./contracts/spu.json";
import {  Route, Routes } from "react-router-dom";
import Nav from "./component/mainParts/Nav/Nav";
import Home from "./component/Pages/Home" ;
import Admin from "./component/Pages/Admin";
import About from "./component/Pages/About";
import Contact from "./component/Pages/Contact"; 
import "./App.css" ;
import Footer from "./component/mainParts/Footer";
import {useState,useEffect} from "react";
import Employe from "./component/Pages/Employe";
import { ethers } from "ethers";







function App() {
  const[walletAddress,setwalletAddress] = useState("");
  const [state, setState] = useState({web3: null,contract: null});
  useEffect(()=>{
    const provider = new web3.providers.HttpProvider("HTTP://127.0.0.1:7545");
    async function template(){
      const web3 = new Web3(provider);
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = spu.networks[networkId];
      const contract = new web3.eth.Contract(spu.abi,deployedNetwork.address);
      //console.log(contract);
      setState({ web3: web3, contract: contract });
    }
provider && template();
  },[]);
  

async function requestAccount() {
  
  if(window.ethereum){
    console.log("detected");
    try{
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setwalletAddress(accounts[0]);
    }catch(error){
      console.log("error connecting");
    }
}else{
    console.log("metamask not detected");
  }
}

  
  async function view_student(){
    const {contract}=state;
    await contract.methods.view_student(0).send({from:walletAddress});
    window.location.reload();
  
  contract && view_student();


  }
    
  async function register_student(){
    const {contract}=state;
    await contract.methods.register_student(0).send({from:walletAddress});

  
  contract && register_student();


  }
  async function check_role(){
    const {contract}=state;
 const  result= await contract.methods.chekRole(walletAddress).send({from:walletAddress});
    window.location.reload();
  console.log(result);
  contract && check_role();

  }












return (
    
  <> 





  <button onClick={requestAccount}>connect wallet</button>
  
  <h3>wallet address : {walletAddress}</h3>
  
  <button onClick={view_student}>check</button>
  <button onClick={check_role}>role</button>
  

<Nav />
<div className="pt-10 h-screen h-auto">  
    <Routes>
      <Route path="/" element= {<Home />} />  
      <Route path="Home" element= {<Home />} />  
      <Route path="about" element= {<About />} />   
      <Route path="contect" element = {<Contact />} /> 

      <Route path="Admin" element = {<Admin />} /> 
      <Route path="Employe" element = {<Employe/>} />
   

    </Routes>
    <Footer/> 
     </div>
  
 
  </>
 ); 
}

export default App;