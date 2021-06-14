const path = require("path");
const glob = require("glob");
const HardSourceWebpackPlugin = require("hard-source-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const VueLoaderPlugin = require("vue-loader/lib/plugin");

module.exports = (env, options) => {
  const devMode = options.mode !== "production";

  return {
    optimization: {
      minimizer: [
        new TerserPlugin({ cache: true, parallel: true, sourceMap: devMode }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    entry: {
      app: glob.sync("./vendor/**/*.js").concat(["./js/app.js"])
    },
    output: {
      filename: "[name].js",
      path: path.resolve(__dirname, "../priv/static/js"),
      publicPath: "/js/"
    },
    devtool: devMode ? "eval-cheap-module-source-map" : undefined,
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: "babel-loader"
          }
        },
        {
          test: /\.[s]?css$/,
          use: [
            process.env.NODE_ENV !== "production"
              ? "vue-style-loader"
              : MiniCssExtractPlugin.loader,
            "css-loader",
            "sass-loader"
          ]
        },
        {
          test: /\.(png|jpg|gif)$/i,
          use: [
            {
              loader: "url-loader",
              options: {
                limit: false
              }
            }
          ],

          type: "javascript/auto"
        },
        {
          test: /\.vue$/,
          loader: "vue-loader"
        }
      ]
    },
    // resolve: {
    //   alias: {
    //     vue$: "vue/dist/vue.esm.js"
    //   },
    //   extensions: ["*", ".js", ".vue", ".json"]
    // },
    plugins: [
      new MiniCssExtractPlugin({ filename: "../css/app.css" }),
      new CopyWebpackPlugin([{ from: "static/", to: "../" }]),
      new VueLoaderPlugin()
    ].concat(devMode ? [new HardSourceWebpackPlugin()] : [])
  };
};
