import { basesepolia, sepolia } from "viem/chains";
import { alchemyBasesepolia, alchemysepolia } from "../lib/alchemy";
import { inngest } from "../lib/inngest";

function getAlchemy(chainId: number) {
  switch (chainId) {
    case basesepolia.id:
      return alchemyBasesepolia;
    case sepolia.id:
      return alchemysepolia;
    default:
      throw new Error("Invalid chainId");
  }
}

function getAlchemyWebhookId(chainId: number) {
  switch (chainId) {
    case basesepolia.id:
      return process.env.ALCHEMY_BASE_sepolia_WEBHOOK_ID as string;
    case sepolia.id:
      return process.env.ALCHEMY_sepolia_WEBHOOK_ID as string;
    default:
      throw new Error("Invalid chainId");
  }
}

export const updateOnchainListenerWebhook = inngest.createFunction(
  { id: "update-onchain-listener-webhook", name: "Update Address Listener" },
  { event: "app/workflow.created" },
  async ({ event, step }) => {
    await step.run("Create Listener", async () => {
      const alchemy = getAlchemy(event.data.chainId);

      await alchemy.notify.updateWebhook(
        getAlchemyWebhookId(event.data.chainId),
        {
          addAddresses: [event.data.address],
        }
      );

      console.info("Listener Updated");
    });
  }
);
