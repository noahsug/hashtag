var main = {
  run: function() {
    return window.addEventListener('keydown', function(e) {
      if (e.which === '51' && e.shiftKey) {
        return this.hashtagify();
      }
    });
  },
  hashtagify: function() {
    var bounds, inputTextInfo, outputTextInfo;
    inputTextInfo = {
      text: document.activeElement.value,
      caret: document.activeElement.selectionStart
    };
    bounds = this.getHashtagBounds(inputTextInfo);
    if (bounds.start < bounds.end) {
      outputTextInfo = this.getHashtaggedText(inputTextInfo, bounds);
      return this.updateDom(outputTextInfo);
    }
  },
  getHashtagBounds: function(textInfo) {
    var bounds, postCaretText, preCaretText;
    bounds = {};
    preCaretText = textInfo.text.substring(0, textInfo.caret);
    postCaretText = textInfo.text.substring(textInfo.caret);
    bounds.start = 0;
    bounds.end = bounds.start + preCaretText.length;
    return bounds;
  },
  getHashtaggedText: function(textInfo, bounds) {
    var outputTextInfo;
    outputTextInfo = {};
    outputTextInfo.text = textInfo.text.replace(/\s/g, '');
    outputTextInfo.caret = bounds.start + outputTextInfo.text.length;
    return outputTextInfo;
  },
  updateDom: function(textInfo) {
    return setTimeout(function() {
      document.activeElement.value = textInfo.text;
      document.activeElement.selectionStart = textInfo.caret;
      return document.activeElement.selectionEnd = textInfo.caret;
    }, 0);
  }
};

main.run();
