<template>
  <div>
    <md-table md-card>
      <md-table-toolbar>
        <h1 class="md-title">Drivers</h1>
        <div>
          <Drivers/>
        </div>
      </md-table-toolbar>
    
      <md-table-row>
        <md-table-head>
          <md-table-cell>
            id
          </md-table-cell>
          <md-table-cell>
            Name
          </md-table-cell>

          <md-table-cell>
            Phone Number
          </md-table-cell>
        </md-table-head>
      </md-table-row>
    </md-table>
  </div>
</template>

<script>
import Drivers from './Drivers.vue';
export default  {
    name: 'DriverPage',
    components: {
    Drivers
  }
}
</script>
