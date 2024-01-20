import { bundlerActions } from 'permissionless';
import {
  pimlicoBundlerActions,
  pimlicoPaymasterActions,
} from 'permissionless/actions/pimlico';
import { createClient, createPublicClient, http, Chain } from 'viem';
import { sepolia } from 'viem/chains';
import { SUPPORTED_CHAINS } from './config';

const apiKey = process.env.NEXT_PUBLIC_YOUR_PIMLICO_API_KEY;

//  supported chains: arbitrum-sepolia, arbitrum-sepolia, arbitrum, avalanche-fuji, avalanche, base-sepolia, base, binance-testnet, binance, celo-alfajores-testnet, celo, chiado-testnet, dfk-chain-test, dfk-chain, ethereum, fuse, gnosis, sepolia, klaytn-cypress, linea-testnet, linea, lyra, mantle, mumbai, nautilus, opbnb, optimism-sepolia, optimism, polygon, scroll-alpha-testnet, scroll-sepolia-testnet, scroll, sepolia, xai-sepolia-orbit

const createBundlerClient = (name: string, chain: Chain) =>
  createClient({
    transport: http(`https://api.pimlico.io/v1/${name}/rpc?apikey=${apiKey}`),
    chain,
  })
    .extend(bundlerActions)
    .extend(pimlicoBundlerActions);

export const BUNDLER_CLIENT = {
  [sepolia.id]: createBundlerClient('sepolia', sepolia),
} satisfies Record<SUPPORTED_CHAINS, any>;

const getPaymasterClient = (name: string, chain: Chain) =>
  createClient({
    transport: http(`https://api.pimlico.io/v2/${name}/rpc?apikey=${apiKey}`),
    chain,
  }).extend(pimlicoPaymasterActions);

export const PAYMASTER_CLIENT = {
  [sepolia.id]: getPaymasterClient('sepolia', sepolia),
} satisfies Record<SUPPORTED_CHAINS, any>;

const getPublicClient = (rpc: string, chain: Chain) =>
  createPublicClient({
    transport: http(rpc),
    chain,
  });

export const PUBLIC_CLIENT = {
  [sepolia.id]: getPublicClient(sepolia.rpcUrls.default.http[0], sepolia),
} satisfies Record<SUPPORTED_CHAINS, any>; 
