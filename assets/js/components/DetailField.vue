<template>
  <panel-item :field="field">
    <template v-slot:value>
      <direct-upload-image-detail v-if="field"
        :field="field"
        :value="field.value"
        class="block pb-4"
      />
    </template>
  </panel-item>
</template>

<script>
export default {
  props: {
    resourceName: {
      type: String,
      required: true
    },
    resourceId: {
      type: [String, Number],
      required: true
    },
    resource: {
      type: Object,
      required: true
    },
    field: {
      type: Object,
      required: true
    }
  }
};
</script>
