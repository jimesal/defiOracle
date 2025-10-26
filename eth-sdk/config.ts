import { defineConfig } from '@dethcrypto/eth-sdk';

export default defineConfig({
  contracts: {
    mainnet: {
      dai: '0x6b175474e89094c44da98b954eedeac495271d0f',
      usdt: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
      uni: '0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984',
      curveRegistry: '0x90E00ACe148ca3b23Ac1bC8C240C2a7Dd9c2d7f5',
      oneSplit: '0xC586BeF4a0992C495Cf22e1aeEE4E446CECDee0E',
      quoter: '0xb27308f9F90D607463bb33eA1BeBb41C27CE5AB6',
      weth: '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2',
      feedRegistry: '0x47Fb2585D2C56Fe188D0E6ec628a38b74fCeeeDf',
    },
  },
});
