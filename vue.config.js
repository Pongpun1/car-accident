const { defineConfig } = require("@vue/cli-service");

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    port: 8080,
    proxy: {
      "/api": {
        // target: "http://localhost:3000",
        target: "http://35.198.205.161",
        changeOrigin: true,
        pathRewrite: { "^/api": "" },
      },
    },
  },
});
