import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'net.meltzow.deckng',
  appName: 'deck-ng',
  webDir: 'www',
  bundledWebRuntime: false,
  plugins: {
    "SplashScreen": {
      "launchAutoHide": false,
      "showSpinner": false
    }
  }
};

export default config;
