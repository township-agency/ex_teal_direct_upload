ExTeal.booting((Vue, router) => {
  Vue.component('imgix-image-detail', require('./components/Shared/ImageDetail').default);
  Vue.component('imgix-image-uploader', require('./components/Shared/ImageUploader').default);


  Vue.component('detail-imgix-array-field', require('./components/DetailArrayField').default);
  Vue.component('form-imgix-array-field', require('./components/FormArrayField').default);
  Vue.component('index-imgix-array-field', require('./components/IndexArrayField').default);

  Vue.component('detail-imgix-field', require('./components/DetailField').default);
  Vue.component('form-imgix-field', require('./components/FormField').default);
  Vue.component('index-imgix-field', require('./components/IndexField').default);
});
