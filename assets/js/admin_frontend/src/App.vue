<template>
  <div id="appComp">
    <router-view/>
    <router-view name="home"></router-view>
      
  </div>
  
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import LoginForm from './components/LoginForm.vue';
import HomePage from './components/HomePage.vue';
export default {
  name: 'App',
  components: {
      HelloWorld,
      LoginForm,
      HomePage

  }
}
</script>

<style>
#appComp {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#login-logo {
    width: 60px;
    height: 60px;
}
</style>














