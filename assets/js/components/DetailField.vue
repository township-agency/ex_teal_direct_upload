<template>
  <panel-item :field="field">
    <template v-slot:value>
      <imgix-image-detail v-if="field"
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
  },

  computed: {
    imgixUrl() {
      return `//${this.field.options.imgix_host}/${this.field.value}`;
    },

    isImgix() {
      return this.field.options.type == "imgix";
    },

    directUrl() {
      if(this.isImgix) {
        return this.imgixUrl;
      }

      if(this.field.options.presign_s3) {
        return this.field.options.presigned_url;
      }

      return `//${this.field.options.s3_host}/${this.field.value}`;
    }
  }
};
</script>
