# Crypto App

Simple Flutter app that shows **live cryptocurrency prices** for **BTC, ETH & USDT** and an embedded **TradingView chart**, built using **Flutter stable version** with **GetX** for state management, routing, and dependency injection.

## Features
- **Custom Dropdown:** Option to select a cypto currrency using custom bottomsheet selector style.
- **Auto-refresh:** Live price update on every 10 seconds.
- **Live Price Display:** Displays the real-time price in USD.
- **TradingView Chart:** Embedded interactive charts for selected coin using a WebView.
- **Loading Indicator:** Added Loading inferface on each action for better user experience.
- **Error Handling:** Handled errors on api consumption by providing user feedback with snackbar and optional tooltip.

## Tech Stack
- **Framework** Flutter
- **State Management** GetX
- **Networking** Dio
- **API Source** CoinGecko
- **Chart Integration** TradingView