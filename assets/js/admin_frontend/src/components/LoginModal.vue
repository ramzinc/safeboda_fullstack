<template>
  <div id="login-div">
    <form id="login-form">
      <span>
        <label for="#email"> Email: </label>
        <input id="email" type="email" required />
      </span>
      <label for="#email"> Password: </label>
      <input id="password" type="password" required />
      <button on:click="login_admin">LOGIN</button>
    </form>
  </div>
</template>
