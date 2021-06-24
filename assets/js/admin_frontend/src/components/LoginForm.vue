<template>
  <div class="centered-container">
    <md-content class="md-elevation-3">
      <img id="login-logo" alt="SafeBoda logo" src="/images/logo.png" />
      <div class="title">
        <div class="md-title">SafeBoda Admin</div>
        <div class="md-body-1">Your City Ride</div>
      </div>

      <div class="form">
        <md-field>
          <label>E-mail: </label>
          <md-input v-model="login.email" autofocus type="email"> </md-input>
        </md-field>

        <md-field>
          <label>Password: </label>
          <md-input v-model="login.password" autofocus type="password">
          </md-input>
        </md-field>
      </div>

      <div class="actions md-layout-md-alignment-center-space-between">
        <md-button class="md-raised md-primary" v-on:click="loginAdmin">
          LOGIN
        </md-button>
      </div>
    </md-content>
    <div class="background"></div>
  </div>
</template>

<script>
module.exports = {
  name: "LoginForm",
  data() {
    return {
      login: {
        email: "",
        password: ""
      }
    };
  },
  methods: {
    loginAdmin() {
      let user = { email: this.login.email, password: this.login.password };
      fetch("http://localhost:4000/login", {
        method: "POST",
        body: JSON.stringify(user),
        headers: { "Content-Type": "application/json" }
      })
        .then(response => {
          return response.json();
        })
        .then(data => {
          //var resp_data = JSON.stringify(data);
          console.log("This is the loginAdmin:");
          console.log(typeof data);
          window.localStorage.setItem("accessSBToken", data.token);
          console.log(data["token"]);
          if (
            window.localStorage.getItem("accessSBToken") != "undefined" ||
            window.localStorage.getItem("accessSBToken") != null
          ) {
            this.$router.push({ name: "home" });
          }
        });
      console.log({ email: this.login.email, password: this.login.password });
    }
  }
};
</script>

<style lang="scss">
.centered-container {
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  height: 100vh;
  .title {
    text-align: center;
    margin-bottom: 30px;
    img {
      margin-bottom: 16px;
      max-width: 80px;
    }
  }
  .actions {
    .md-button {
      margin: 0;
    }
  }
  .form {
    margin-bottom: 60px;
  }

  .md-content {
    z-index: 1;
    padding: 40px;
    width: 100%;
    max-width: 400px;
    position: relative;
  }
  .loading-overlay {
    z-index: 10;
    top: 0;
    left: 0;
    right: 0;
    position: absolute;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.9);
    display: flex;
    align-items: center;
    justify-content: center;
  }
}
</style>
