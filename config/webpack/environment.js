const { environment } = require("@rails/webpacker");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

const webpack = require("webpack")
environment.plugins.prepend("Provide", new webpack.ProvidePlugin({
  $: "jquery",
  jQuery: "jquery",
  Popper: ["popper.js", "default"],
  I18n: "i18n-js",
  React: "react",
  BlockUi: ["react-block-ui", "default"],
  _: "underscore"
}));

environment.plugins.append("MiniCssExtract", new MiniCssExtractPlugin());

environment.module = {
  rules: [
    {
      test: /\.css$/i,
      use: [MiniCssExtractPlugin.loader, "css-loader"]
    },
    {
      test: /\.scss$/,
      use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"]
    }
  ]
};

module.exports = environment
