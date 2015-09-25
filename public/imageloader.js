function setImage() {
  var httpRequest = new XMLHttpRequest();
  
  httpRequest.onreadystatechange = function(){
    if (httpRequest.readyState === 4) {
      var imgData = JSON.parse(httpRequest.responseText);
      document.getElementById('title').innerHTML = imgData.title;
      document.getElementById('image').setAttribute('src', imgData.url)
    };
  };
  httpRequest.open('GET', '/image.json', true);
  httpRequest.send();
}

setImage();

window.setInterval("setImage()", 30000);
