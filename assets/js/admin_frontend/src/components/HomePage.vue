<template>
  <div class="page-container">
    <md-app md-waterfall md-mode="fixed-last">
      <md-app-toolbar class="md-primary md-dense ">
        <div class="md-toolbar-row">
          <div class="md-toolbar-section-start">
            <md-button
              class="md-icon-button"
              @click="toggleMenu"
              v-if="!menuVisible"
            >
              <md-icon>menu</md-icon>
            </md-button>
            <span><h3 class="md-title">Hello SafeBoda Admin</h3></span>
          </div>
        </div>

        <!-- <div class="md-toolbar-row">
             <md-tabs class="md-primary" md-sync-route>
             <md-tab id="passengers" md-label="Passengers">
             <router-view name="passengerPage" />
             </md-tab>
             <md-tab id="drivers" md-label="Drivers">
             <router-view name="driverPage"/> -->
        <!-- </md-tab>
             <md-tab id="ongoingrides" md-label="Ongoing Rides"> </md-tab>
             </md-tabs>
             </div> -->
      </md-app-toolbar>
      <md-app-drawer md-persistent="full" :md-active.sync="menuVisible">
        <md-toolbar class="md-transparent" md-elevation="0">
          <div class="md-toolbar-section-end">
            <md-button class="md-icon-button md-dense" @click="toggleMenu">
              <md-icon>keyboard_arrow_left</md-icon>
            </md-button>
          </div>
        </md-toolbar>

        <md-list>
          <md-list-item>
            <md-button class="md-raised md-ripple" @click="toDriverPage">
              <md-icon>two_wheeler</md-icon>
              <span>Drivers </span>
            </md-button>
          </md-list-item>

          <md-list-item>
            <md-button class="md-raised md-ripple" @click="toPassengerPage">
              <md-icon>sports_motorsports</md-icon>
              <span>Passengers </span>
            </md-button>
          </md-list-item>
        </md-list>
      </md-app-drawer>

      <md-app-content>
        <router-view />
        <!-- <router-view name="drivers"></router-view> -->
        <!-- <router-view name="passengers"></router-view> -->
      </md-app-content>
    </md-app>
  </div>
</template>

<script>
import PassengerPage from "./PassengerPage.vue";
import DriverPage from "./DriverPage.vue";
export default {
  name: "HomePage",
  data: () => ({
    menuVisible: false
  }),
  components: {
    PassengerPage,
    DriverPage
  },
  methods: {
    toggleMenu() {
      this.menuVisible = !this.menuVisible;
    },
    toDriverPage() {
      this.$router.push({ name: "drivers" });
    },
    toPassengerPage() {
      this.$router.push({ name: "passengers" });
    }
  }
};
</script>

<style lang="scss" scoped>
.md-drawer {
  width: 250px;
}

.md-app {
  min-height: 100vh;
}
</style>
