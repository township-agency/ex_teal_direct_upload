ExTeal.booting((Vue, router) => {
  Vue.component('detail-imgix-field', require('./components/DetailField').default);
  Vue.component('form-imgix-field', require('./components/FormField').default);
  Vue.component('index-imgix-field', require('./components/IndexField').default);
});
