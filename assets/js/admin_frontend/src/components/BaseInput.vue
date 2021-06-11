<template>
  <div>
    <input :[type]="inputType" />
  </div>
</template>

<script>
export default = {
    name: "base-input",
    props: {
        type: {
            type: String,
        description: "Input"

    }

}
</script>
