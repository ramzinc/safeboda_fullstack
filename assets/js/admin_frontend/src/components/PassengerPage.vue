<template>
  <div>
    <md-table md-card>
      <md-table-toolbar>
        <h1 class="md-title">Passengers</h1>
        <div>
          <Passengers />
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
import Passengers from './Passengers.vue';
export default  {
    name: 'PassengerPage',
    components: {
    Passengers
  }
}
</script>
