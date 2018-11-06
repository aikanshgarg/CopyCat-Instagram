// we created this file to let Dropzone upload files using cloudinary service

// 1 = 1mb
// autoProcessQueue: false as dropzone by default uploads the photo moment we select it, but we want user to be able to select more than 1 photo

Dropzone.autoDiscover = false;

$(document).ready(function() {
	$(".upload-images").dropzone( {
		addRemoveLinks: true,
		maxFilesize: 1,
		autoProcessQueue: false,
		uploadMultiple: true, 
		parallelUploads: 100,
		maxFiles: 100,
		paramName: "images",
		previewsContainer: ".dropzone-previews",
		clickable: ".upload-photos-icon",
		thumbnailWidth: 100,
		thumbnailHeight: 100,

		init: function() {
			var myDropzone = this;


			this.element.querySelector("input[type=submit]").addEventListener("click", function(e) {
				e.preventDefault();
				e.stopPropagation();
				myDropzone.processQueue();
			});

			this.on("successmultiple", function(files, response) {
				window.location.reload();
			});

			this.on("errormultiple", function(files, response) {
				toastr.error(response);
			});
		}
	})
});