import axios from "axios";
import ImageDetail from "./components/Shared/ImageDetail.vue";
import ImageUploader from "./components/Shared/ImageUploader.vue";

import DetailArrayField from "./components/DetailArrayField.vue";
import FormArrayField from "./components/FormArrayField.vue";
import IndexArrayField from "./components/IndexArrayField.vue";

import DetailField from "./components/DetailField.vue";
import FormField from "./components/FormField.vue";
import IndexField from "./components/IndexField.vue";

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

  Vue.component('direct-upload-image-detail', ImageDetail);
  Vue.component('direct-upload-image-uploader', ImageUploader);

  Vue.component('detail-image-array-field', DetailArrayField);
  Vue.component('form-image-array-field', FormArrayField);
  Vue.component('index-image-array-field', IndexArrayField);

  Vue.component('detail-image-field', DetailField);
  Vue.component('form-image-field', FormField);
  Vue.component('index-image-field', IndexField);
});
