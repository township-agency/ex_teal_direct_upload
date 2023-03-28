ExTeal.booting((Vue, router) => {
  Vue.component('direct-upload-image-detail', require('./components/Shared/ImageDetail').default);
  Vue.component('direct-upload-image-uploader', require('./components/Shared/ImageUploader').default);


  Vue.component('detail-image-array-field', require('./components/DetailArrayField').default);
  Vue.component('form-image-array-field', require('./components/FormArrayField').default);
  Vue.component('index-image-array-field', require('./components/IndexArrayField').default);

  Vue.component('detail-image-field', require('./components/DetailField').default);
  Vue.component('form-image-field', require('./components/FormField').default);
  Vue.component('index-image-field', require('./components/IndexField').default);
});
