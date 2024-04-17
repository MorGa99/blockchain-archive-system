import web3, { Web3 } from "web3";
import spu from "./contracts/spu.json";
import {useState,useEffect} from "react";
import './App.css';

function App() {

  const [state, setState] = useState({web3: null,contract: null});
  useEffect(()=>{
    const provider = new web3.providers.HttpProvider("HTTP://127.0.0.1:7545");
    async function template(){
      const web3 = new Web3(provider);
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = spu.networks[networkId];
      const contract = new web3.eth.Contract(spu.abi,deployedNetwork.address);
      setState({ web3: web3, contract: contract });
    }
provider && template();
  },[])
 
  return (
    <div className="App">

    </div>
  );
}

export default App;
