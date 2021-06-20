    import Vue from "vue";
    import VueRouter from "vue-router";
    import HomePage from "../components/HomePage.vue";
    import LoginForm from "../components/LoginForm.vue";
    import PassengerPage from "../components/PassengerPage.vue";
    import DriverPage from "../components/DriverPage.vue";

    Vue.use(VueRouter);
    const routes = [
      {
        path: "/home",
        component: HomePage,
        name: "home",
        children: [
          { path: "passengers", component: PassengerPage, name: "passengers" },
          { path: "drivers", component: DriverPage, name: "drivers" }
        ]
      },
      {
        path: "/",
        component: LoginForm
      }
      // {
      //   path: "/passengers",
      //   component: PassengerPage,
      //   name: "passenger"
      // },
      // {
      //   path: "/drivers",
      //   component: DriverPage,
      //   name: "driver"
      // }
    ];
    const router = new VueRouter({ mode: "history", routes });

    export default router;
