function imageLoader(imgData) {
  var image = new Image()
  image.src = imgData.url
  image.onload = function() {
    document.title = imgData.title;
    document.getElementById('title').innerHTML = imgData.title;
    document.getElementById('image').setAttribute('src', imgData.url);
    document.getElementById('description').innerHTML = imgData.description;
  };
}


function setImage() {
  var httpRequest = new XMLHttpRequest();
  
  httpRequest.onreadystatechange = function(){
    if (httpRequest.readyState === 4) {
      var imgData = JSON.parse(httpRequest.responseText);
      imageLoader(imgData);  
  };
  };
  httpRequest.open('GET', '/image.json', true);
  httpRequest.send();
}

setImage();

window.setInterval("setImage()", 30000);
