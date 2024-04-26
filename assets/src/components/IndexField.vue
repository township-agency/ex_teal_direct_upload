<template>
  <div class="flex">
    <img
      v-if="canShowUrl"
      :src="imageUrl"
      style="object-fit: cover;"
      class="w-8 h-8"
    />
    <span v-else>&mdash;</span>
  </div>
</template>

<script>
export default {
  props: {
    resourceName: {
      type: String,
      default: "",
    },
    field: {
      type: Object,
      default() {
        return {};
      },
    },
  },

  computed: {
    canShowUrl() {
      const { options, value } = this.field;
      return options.type === "image" && value;
    },
    imageUrl() {
      const { options, value} = this.field;
      if (options.imgix_host) {
        return `https://${options.imgix_host}/${value}?w=${options.width}&h=${options.height}`;
      }
      return `https://${options.s3_host}/${value}`;
    },
  },
};
</script>
