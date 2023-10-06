import axios from "axios";

ExTeal.booting((Vue, router) => {
  window.ExTealDirectUpload = {};

  ExTealDirectUpload.uploadFile = async (file, progressCallback) => {
    let { type, name } = file;
    console.log({type, name})
    let { data: response } = await ExTeal.request().post(
      "/plugins/direct-upload/sign",
      {
        fileName: name,
        contentType: type
      }
    );
    let config = {
      onUploadProgress: progressCallback,
      headers: { "Content-Type": "multipart/form-data" },
      responseType: "document"
    };
    let fd = new FormData();
    let signature = response.signature;
    Object.keys(signature).forEach(key => {
      fd.append(key, signature[key]);
    });
    fd.append("file", file);
    const s3Response = await axios.post(response.postEndpoint, fd, config);
    const url = s3Response.data.getElementsByTagName("Location")[0].childNodes[0].nodeValue;
    const path = s3Response.data.getElementsByTagName('Key')[0].childNodes[0].nodeValue;
    const status = s3Response.status;

    const jsConfig = window.ExTeal.config.plugins.find((i) => i.uri == 'direct-upload').js_config

    const imgixCompatibleType = type.startsWith('image') && jsConfig.imgix_source;

    const updatedUrl = imgixCompatibleType ? `https://${jsConfig.imgix_source}/${path}` : url;

    return { value: path, url: updatedUrl, status };
  }

  Vue.component('direct-upload-image-detail', require('./components/Shared/ImageDetail').default);
  Vue.component('direct-upload-image-uploader', require('./components/Shared/ImageUploader').default);


  Vue.component('detail-image-array-field', require('./components/DetailArrayField').default);
  Vue.component('form-image-array-field', require('./components/FormArrayField').default);
  Vue.component('index-image-array-field', require('./components/IndexArrayField').default);

  Vue.component('detail-image-field', require('./components/DetailField').default);
  Vue.component('form-image-field', require('./components/FormField').default);
  Vue.component('index-image-field', require('./components/IndexField').default);
});
