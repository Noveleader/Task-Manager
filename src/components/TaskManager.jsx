import React, { useState } from "react";
import { Contract, ethers } from "ethers";
import "./TaskManager.css";
import abi from "../contracts/out/TaskManager.sol/TaskManager.json";
import { contractAddresses } from "../contracts/scripts/addresses";

export default function TaskManager() {
    const [task, setTask] = useState("");
    const [userAccountAddress, setUserAccountAddress] = useState("");
    const [signer, setSigner] = useState(null);
    const taskManagerContractAddress = contractAddresses.taskManager;
    const ABI = abi.abi;

    const connectWallet = async () => {
        let provider;
        if (window.ethereum == null) {
            alert("MetaMask not installed; using read-only defaults");
            provider = ethers.getDefaultProvider();
        } else {
            provider = new ethers.BrowserProvider(window.ethereum);
            const signer = await provider.getSigner();
            setUserAccountAddress(signer.address);
            setSigner(signer);
        }
    };

    const handleAddTask = async () => {
        const contract = new ethers.Contract(
            taskManagerContractAddress,
            ABI,
            signer
        );
        const tx = await contract.addItem(task);
        await tx.wait();
    };

    return (
        <>
            <div className="project-title">Task Manager App</div>
            <button className="connect-button" onClick={connectWallet}>
                {userAccountAddress
                    ? `${userAccountAddress.substring(
                          0,
                          6
                      )}...${userAccountAddress.substring(
                          userAccountAddress.length - 4
                      )}`
                    : "Connect Wallet"}
            </button>
            <input
                type="text"
                className="task-box"
                placeholder="Add your task here"
                value={task}
                onChange={(e) => setTask(e.target.value)}
            ></input>
            <button
                type="submit"
                className="submit-button"
                onClick={handleAddTask}
            >
                Add Task
            </button>
        </>
    );
}
