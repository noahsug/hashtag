window.addEventListener(function(e) {
  console.log('w', e.which, 's', e.shiftKey, '#?', e.which == '51' && e.shiftKey);
  if (e.which == '51' && e.shiftKey) {
    maybeHashtagify();
  }
});

var maybeHashtagify = function() {
  console.log('INPUT:', document.activeElement.value);
  var inputText = document.activeElement.value;
  if (inputText) {
    var outputText = '#' + inputText;
    document.activeElement.value = outputText;
  }
}
