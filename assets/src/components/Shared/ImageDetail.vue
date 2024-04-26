<template>
  <p v-if="field.value" slot="value" class="text-90">
    <img :src="imageUrl" class="block mb-2 w-48" v-if="imageUrl"/>
    <a
      :href="directUrl"
      target="_blank"
      class="btn btn-default btn-primary btn-icon-inline"
    >
      <icon type="link" class="mr-2" /> <span>Link</span>
    </a>
  </p>
</template>

<script>
export default {
  props: {
    field: {
      type: Object,
      required: true
    }
  },
  computed: {
    imageUrl() {
      const { options, value } = this.field;
      const host = options.imgix_host || options.s3_host;
      if (options.type === 'file') return false;
      return `https://${host}/${value}`;
    },
    directUrl() {
      const { options, value } = this.field;
      const host = options.imgix_host || options.s3_host;
      if(options.presign_s3) {
        return this.field.options.presigned_url;
      }

      return `https://${host}/${value}`;
    }
  }
};
</script>