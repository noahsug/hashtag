window.addEventListener(function(e) {
  if (e.which == '51' && e.shiftKey) {
    maybeHashtagify();
  }
});

var maybeHashtagify = function() {
  var inputText = document.activeElement.value;
  if (inputText) {
    var outputText = '#' + inputText;
    document.activeElement.value = outputText;
  }
}
