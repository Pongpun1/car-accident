const { defineConfig } = require("@vue/cli-service");

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    port: 8080,
    proxy: {
      "/api": {
        target: "http://34.124.168.71:3000",
        changeOrigin: true,
        pathRewrite: { "^/api": "" },
      },
    },
  },
});
