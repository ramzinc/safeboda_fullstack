import Vue from "vue";
import App from "./App.vue";
import router from "./router/vue-router.js";
import HomePage from "./components/HomePage.vue";
import LoginForm from "./components/LoginForm.vue"
Vue.config.productionTip = false;

import VueMaterial from "vue-material";
import "vue-material/dist/vue-material.min.css";
import "vue-material/dist/theme/default.css";

Vue.use(VueMaterial);

new Vue({
  router,
  render: h => h(App)
}).$mount("#app");
