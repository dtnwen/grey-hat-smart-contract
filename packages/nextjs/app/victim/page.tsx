"use client";

import { useState } from "react";
import { useAccount, useSendTransaction } from "wagmi";
import { AddressInput, InputBase } from "~~/components/scaffold-eth";
import { useScaffoldReadContract, useScaffoldWriteContract } from "~~/hooks/scaffold-eth";

const Victim = () => {
  const { writeContractAsync: writeYourContractAsync } = useScaffoldWriteContract("GreyHat");
  const { address: connectedAddress } = useAccount();
  const [address, setAddress] = useState("");
  const [message, setMessage] = useState<string>("Hello my dear Hacker");
  const { sendTransaction } = useSendTransaction();

  const implement = async () => {
    try {
      await writeYourContractAsync({
        functionName: "implement",
      });
    } catch (e) {
      console.error("Error implementing", e);
    }
  };

  const sendMessage = async () => {
    try {
      await sendTransaction({
        to: address,
      });
    } catch (error) {
      console.error("Error sending message", error);
    }
  };

  const { data: implemented } = useScaffoldReadContract({
    contractName: "GreyHat",
    functionName: "implemented",
    args: [connectedAddress],
  });

  return (
    <div>
      <div>
        {!implemented && (
          <div>
            <div>Unluckily, your fund just got exploited, what to do now?</div>
            <div>
              Let give the exploiter a chance to return you money, but in exchange, he/she will get 10% of the fund,
              agree?
            </div>
            <div>
              <button className="btn btn-primary" onClick={implement}>
                Agree
              </button>
            </div>
          </div>
        )}
      </div>
      <div>
        <h1>Let&apos;s give the hacker a heads up!</h1>
        <div>
          <span>Hacker&apos;s address:</span>
          <AddressInput onChange={setAddress} value={address} placeholder="Input hacker's address" />
        </div>
        <div>
          <span>Message</span>
          <InputBase name="message" placeholder="My dear hacker, . . ." value={message} onChange={setMessage} />
        </div>
      </div>
      <button className="btn" onClick={sendMessage}>
        Send
      </button>
    </div>
  );
};

export default Victim;
