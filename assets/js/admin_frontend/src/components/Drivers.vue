<template>
  <div>
    <md-card md-with-hover>
      <md-card-header>
        <div class="title">
          <h2>Create Drivers</h2>
        </div>
      </md-card-header>
      <md-card-content>
        <div class="form md-layout md-gutter md-alignment-center">
          <div class="md-layout-item md-small-size-100">
            <md-field>
              <label> First Name</label>
              <md-input id="last-name" v-model="firstName"> </md-input>
            </md-field>
          </div>
          <div class="md-layout-item md-small-size-100">
            <md-field class="md-layout-item md-small-size-100">
              <label> Last Name</label>
              <md-input id="last-name" v-model="lastName"></md-input>
            </md-field>
          </div>
          <div class="md-layout-item md-small-size-100">
            <md-field class="md-layout-item md-small-size-100">
              <label> Phone Number</label>
              <md-input id="phone-number" v-model="phoneNumber"></md-input>
            </md-field>
          </div>
        </div>
        <md-dialog-alert
          :md-active.sync="created"
          md-content="Driver has been created!"
          md-confirm-text="Great!"
        />
      </md-card-content>
      <md-card-actions>
        <md-button type="submit" class="md-primary" v-on:click="createDriver"
          >Create Driver</md-button
        >
      </md-card-actions>
    </md-card>
  </div>
</template>

<script>
module.exports = {
  name: "Drivers",
    data() {
        return {
            firstName: "",
            lastName: "",
            phoneNumber: "",
            created: false
            }
  },
  methods: {
    createDriver() {
      let accessToken = window.localStorage.getItem("accessSBToken");
      if (accessToken != null) {
        let url = "http://localhost:4000/admin/driver";
        let opts = {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${accessToken}`
          },
          body: JSON.stringify({
            first_name: this.firstName,
            last_name: this.lastName,
            phone_number: this.phoneNumber
          })
        };

        let driver = fetch(url, opts)
          .then(response => {
            return response.json();
          })
          .then(data => {
            //let resp_data = JSON.stringify(data);
              if (data != null) {
                  console.log("I Enteted Creative Space")
                  this.created = true;
                  this.$emit("driver-created");
                  console.log(data);
                  return data;
            }
          });
      }
    }
  }
};
</script>
