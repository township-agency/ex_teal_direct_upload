<template>
  <default-field :field="field" :errors="errors">
    <template slot="field">
      <direct-upload-image-uploader :field="field" :value="field.value" v-if="field" @input="handleInput"/>
    </template>
  </default-field>
</template>

<script>
import { FormField, HandlesValidationErrors } from "ex-teal-js";

export default {
  mixins: [HandlesValidationErrors, FormField],

  methods: {
    handleInput(val) {
      this.value = val;
      this.field.value = val;
    }
  }
};
</script>
