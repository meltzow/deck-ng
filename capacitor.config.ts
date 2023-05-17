import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'net.meltzow.deckng',
  appName: 'deck NG',
  webDir: 'www',
  bundledWebRuntime: false,
  overrideUserAgent: "deck NG",
  plugins: {
    SplashScreen: {
      launchAutoHide: false,
      showSpinner: true
    },
    CapacitorHttp: {
      enabled: true
    }
  }
};

export default config;
