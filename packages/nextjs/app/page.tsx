"use client";

import Link from "next/link";
import type { NextPage } from "next";

// import { useAccount } from "wagmi";
// import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
// import { Address } from "~~/components/scaffold-eth";

const Home: NextPage = () => {
  // const { address: connectedAddress } = useAccount();

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <h1 className="text-center">
            <span className="block text-2xl mb-2">Welcome to Grey Hat</span>
            <span className="block text-4xl font-bold">I am</span>
          </h1>
          <div className="flex w-full">
            <Link href="/victim">
              <div className="grid h-20 m-1 flex-grow card bg-base-300 rounded-box place-items-center hover:bg-info">
                an unlucky guy
              </div>
            </Link>
            <div className="divider divider-horizontal">OR</div>
            <div className="grid h-20 m-1 flex-grow card bg-base-300 rounded-box place-items-center hover:bg-info">
              <Link href="/exploiter">a good hacker</Link>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Home;
