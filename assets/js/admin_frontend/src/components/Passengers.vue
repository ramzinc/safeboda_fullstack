<template>
  <div>
  <md-card md-with-hover>
    <md-card-header>
      <div class="title">
               <h2>Create Passengers</h2>         
       </div>
    </md-card-header>
    <md-card-content>
      <div class="form">
        <md-field>
          <label> First Name</label>
          <md-input id="last-name" v-model="firstName">
          </md-input>
        </md-field>

        <md-field>
          <label> Last Name</label>
          <md-input id="last-name" v-model="lastName"></md-input>
        </md-field>

        <md-field>
          <label> Phone Number</label>
          <md-input id="phone-number" v-model="phoneNumber"></md-input>
        </md-field>
        </div>
    </md-card-content>
    <md-card-actions>
      <md-button type="submit" class="md-primary" v-on:click="createPassenger">Create Passenger</md-button>
    </md-card-actions>
  
  </md-card>
  </div>
</template>

<script>
module.exports = {
    name: "Passengers",
    data: {
    firstName: "",
    lastName: "",
    }
}
</script>
