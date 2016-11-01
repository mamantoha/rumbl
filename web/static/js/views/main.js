export default class MainView {
  mount() {
    // This will be executed when the document loads...
    console.log('MainView mounted');
    var csrf = document.querySelector("meta[name=csrf]").content;

    $(function() {
      var deleteFile, sendFile;

      document.addEventListener('trix-attachment-add', function(event) {
        var attachment;
        console.log("add image!");
        attachment = event.attachment;
        if (attachment.file) {
          return sendFile(attachment);
        }
      });

      document.addEventListener('trix-attachment-remove', function(event) {
        var attachment;
        console.log("remove image!")
        attachment = event.attachment;
        return deleteFile(attachment);
      });

      sendFile = function(attachment) {
        var file, form, xhr;
        file = attachment.file;

        form = new FormData;
        form.append('Content-Type', file.type);
        form.append('attachment[file]', file, 'image.png');
        form.append('_csrf_token', csrf);

        xhr = new XMLHttpRequest;
        xhr.open('POST', '/manage/attachments', true);
        xhr.upload.onprogress = function(event) {
          var progress;
          progress = void 0;
          progress = event.loaded / event.total * 100;
          return attachment.setUploadProgress(progress);
        };

        xhr.onload = function() {
          var response;
          response = JSON.parse(this.responseText);
          return attachment.setAttributes({
            url: response.url,
            image_id: response.id,
            href: response.url
          });
        };
        return xhr.send(form);
      };

      return deleteFile = function(n) {
        return $.ajax({
          type: 'DELETE',
          url: "/manage/attachments/" + n.attachment.attributes.values.image_id + "?_csrf_token=" + csrf,
          cache: false,
          contentType: false,
          processData: false
        });
      };
    });

  }

  unmount() {
    // This will be executed when the document unloads...
    console.log('MainView unmounted');
  }
}
