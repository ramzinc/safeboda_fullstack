<template>
  <div>
    <div>
      <Drivers @driver-created="driverCreated" />
    </div>
    <md-table md-card v-model="drivers" :key="updated">
      <md-table-toolbar>
        <h1 class="md-title">Drivers</h1>
      </md-table-toolbar>

      <md-table-row slot="md-table-row" slot-scope="{ item }">
        <md-table-cell md-label="id">
          {{ item.id }}
        </md-table-cell>
        <md-table-cell md-label="Name">
          {{ item.name }}
        </md-table-cell>

        <md-table-cell md-label="Phone_Number">
          {{ item.phone_number }}
        </md-table-cell>

        <md-table-cell md-label="Suspended">
          {{ item.suspended }}
        </md-table-cell>
      </md-table-row>
    </md-table>
  </div>
</template>

<script>
import Drivers from "./Drivers.vue";
export default {
  name: "DriverPage",
  components: {
    Drivers
  },
  data() {
    return {
      updated: 0,
      drivers: []
    };
  },
  methods: {
    getDrivers: async function() {
      let url = "http://localhost:4000/admin/drivers";
      const drivers = await fetch(url, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${window.localStorage.getItem(
            "accessSBToken"
          )}`
        }
      }).then(response => {
        return response.json();
      });
      return drivers;
    },
    driverCreated: function(event) {
      console.log(event);
      console.log("I AM IN THE EVENT HANDLER");
      this.updated = this.updated + 1;
      //this.updated = true;
      //this.$forceUpdate();
    }
  },
  mounted() {
    let a = async () => {
      console.log("THE DRIVERS:");
      //this.drivers = this.getDrivers();
      return await this.getDrivers();
    };
    this.$nextTick(function() {
      a().then(data => {
        console.log("FILLED DRIVERS");

        this.drivers = data;
        console.log(this.drivers);
      });
    });
  }
};
</script>

<style></style>
