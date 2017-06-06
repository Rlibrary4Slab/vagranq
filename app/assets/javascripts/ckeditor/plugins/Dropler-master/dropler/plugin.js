var editors = []
var ei = 0
CKEDITOR.plugins.add( 'dropler', {
    init: function( editor ) {
        backends = {
            imgur: {
                upload: uploadImgur,
                required: ['clientId'],
                init: function() {}
            },
            s3: {
                upload: uploadS3,
                required: [
                    'bucket', 'accessKeyId','secretAccessKey', 'region'
                ],
                init: function() {
                    var script = document.createElement('script');
                    script.async = 1;
                    script.src = 'https://sdk.amazonaws.com/js/aws-sdk-2.1.26.min.js';
                    document.body.appendChild(script);
                }
            },
            basic: {
                upload: uploadBasic,
                required: ['uploadUrl'],
                init: function() {}
            }
        };
        editors[ei] = editor;
        var checkRequirement = function(condition, message) {
            if (!condition)
                throw Error("Assert failed" + (typeof message !== "undefined" ? ": " + message : ""));
        };

        function validateConfig() {
            var errorTemplate = 'DragDropUpload Error: ->';
            checkRequirement(
                editor.config.hasOwnProperty('droplerConfig'),
                errorTemplate + "Missing required droplerConfig in CKEDITOR.config.js"
            );

            var backend = backends[editor.config.droplerConfig.backend];
            var suppliedKeys = Object.keys(editor.config.droplerConfig.settings);
            var requiredKeys = backend.required;

            var missing = requiredKeys.filter(function(key) {
                return suppliedKeys.indexOf(key) < 0
            });

            if (missing.length > 0) {
                throw 'Invalid Config: Missing required keys: ' + missing.join(', ')
            }
        }

        validateConfig();
	
        var backend = backends[editor.config.droplerConfig.backend];
        backend.init();

        function doNothing(e) {

	}

        function orPopError(err) { 
		alert(err.data.error)
	}

        function dropHandler(e) {
	    $("body").before('<div id="loadingajax" style="opacity:0.5; height:999999px; width:999999px; background-color: #FFFFFF; z-index: 10000; position:absolute;"></div>');
            $("#loadingajax").append('<img src="http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif" style="position: fixed; bottom: 0; top: 0; left: 0; right: 0; margin: auto; z-index: 10000;"></div>');
            e.preventDefault();
            var file = e.dataTransfer.files[0];
            backend.upload(file).then(insertImage, orPopError);
        }

        function insertImage(href) {
	    editor = editors[$("#mouseOverSum").val()];
            /*var elem = editor.document.createElement('img', {
                attributes: {
                    src: href
                }
            });*/
            //var elem = editor.setHtml('<p><img src="'+href+'"></p>')
	    //console.log(elem)
            /*editor.insertElement(elem);*/
            editor.insertHtml('<p><img style="max-width:100%; height:100%" src="'+href+'" /></p>\n');
            $("#loadingajax").remove()
        }

        function addHeaders(xhttp, headers) {
            for (var key in headers) {
                if (headers.hasOwnProperty(key)) {
                    xhttp.setRequestHeader(key, headers[key]);
                }
            }
        }

        function post(url, data, headers) {
            return new Promise(function(resolve, reject) {
                var xhttp    = new XMLHttpRequest();
                xhttp.open('POST', url);
                addHeaders(xhttp, headers);
                xhttp.onreadystatechange = function () {
                    if (xhttp.readyState === 4) {
                        if (xhttp.status === 200) {
                            resolve(JSON.parse(xhttp.responseText).data.link);
                        } else {
                            reject(JSON.parse(xhttp.responseText));
                        }
                    }
                };
                xhttp.send(data);
            });
        }

        function uploadBasic(file) {
            var settings = editor.config.droplerConfig.settings;
            return post(settings.uploadUrl, file, settings.headers);
        }

        /*function uploadImgur(file) {
            var settings = editor.config.droplerConfig.settings;
            return post('http://api.imgur.com/3/image', file, {'Authorization': settings.clientId});
        }*/
        function uploadImgur(file) {
            return new Promise(function(resolve, reject) {
                var xhttp = new XMLHttpRequest();
                xhttp.open('POST', 'https://api.imgur.com/3/image');
                xhttp.setRequestHeader('Authorization', 'Client-ID efac5e8b88240c9'); 
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState === 4) {
                        if (xhttp.status === 200) {
                            resolve(JSON.parse(xhttp.responseText).data.link);
			    
                        } else {
                            reject(JSON.parse(xhttp.responseText));
                        }
                    }
                };
                xhttp.send(file);
            });
          }

        function uploadS3(file) {
            var settings = editor.config.droplerConfig.settings;
            AWS.config.update({accessKeyId: settings.accessKeyId, secretAccessKey: settings.secretAccessKey});
            AWS.config.region = 'us-east-1';

            var bucket = new AWS.S3({params: {Bucket: settings.bucket}});
            var params = {Key: file.name, ContentType: file.type, Body: file, ACL: "public-read"};
            return new Promise(function(resolve, reject) {
                bucket.upload(params, function (err, data) {
                    if (!err) resolve(data.Location);
                    else reject(err);
                });
            });
        };
        CKEDITOR.on('instanceReady', function() {
            //var iframeBase = document.querySelector('iframe').contentDocument.querySelector('html');
            //var iframeBody = iframeBase.querySelector('body');
            //var iframeBody = iframeBase.querySelector('body');
            var iframeBase = document.querySelector('iframe').contentDocument.querySelector('html');
            var iframeBaseA = document.querySelector('iframe');
            var iframeBaseB = document.querySelectorAll('iframe');
            //iframeBody.ondragover = doNothing;
            //iframeBody.ondrop = dropHandler;
            for(var i=0;i<iframeBaseB.length-1;i++){
            //iframeBase.ondragover = doNothing;
            //iframeBase.ondrop = dropHandler;
            //htmlBase[i] = iframeBaseB[i].contentDocument.querySelectorAll("html")
             iframeBaseB[i].contentDocument.querySelector("html").ondragover = doNothing;
             iframeBaseB[i].contentDocument.querySelector("html").ondrop = dropHandler;
	    }
            console.log("aaaa")          
            //paddingToCenterBody = ((iframeBase.offsetWidth - iframeBody.offsetWidth) / 2) + 'px';
            //iframeBase.style.height = '100%';
            //iframeBase.style.width = '100%';
            //iframeBase.style.overflowX = 'hidden';

            //iframeBody.style.height = '100%';
            //iframeBody.style.margin = '0';
            //iframeBody.style.paddingLeft = paddingToCenterBody;
            //iframeBody.style.paddingRight = paddingToCenterBody;
        });
	ei++;
    }
});
