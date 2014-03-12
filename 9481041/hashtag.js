var main = {
  run: function() {
    return window.addEventListener('keydown', function(e) {
      if (e.which === 51 && e.shiftKey) {
        return main.hashtagify();
      }
    });
  },
  hashtagify: function() {
    var bounds, inputTextInfo, outputTextInfo;
    if (document.activeElement.selectionStart !== document.activeElement.selectionEnd) {
      return;
    }
    inputTextInfo = {
      text: document.activeElement.value,
      caretStart: document.activeElement.selectionStart,
      caretEnd: document.activeElement.selectionEnd
    };
    bounds = main.getHashtagBounds(inputTextInfo);
    if (bounds.start < bounds.end) {
      outputTextInfo = main.getHashtaggedText(inputTextInfo, bounds);
      return main.updateDom(outputTextInfo);
    }
  },
  getHashtagBounds: function(textInfo) {
    var lastHashtagDistance, singleLine, split, text;
    text = textInfo.text.substring(0, textInfo.caretEnd);
    if (/\s$/.test(text)) {
      return {};
    }
    singleLine = (split = text.split('\n'))[split.length - 1];
    lastHashtagDistance = main.reverseStr(singleLine).search(/\s*\S+#(\s|$)/);
    if (lastHashtagDistance === -1) {
      lastHashtagDistance = singleLine.length;
    }
    return {
      start: textInfo.caretEnd - lastHashtagDistance,
      end: textInfo.caretEnd
    };
  },
  getHashtaggedText: function(textInfo, bounds) {
    var hashtag, output, textToHashtag;
    textToHashtag = textInfo.text.substring(bounds.start, bounds.end);
    hashtag = main.formHashtag(textToHashtag);
    output = main.spliceStr(textInfo.text, bounds.start, bounds.end, hashtag);
    return {
      text: output,
      caretStart: bounds.start + hashtag.length,
      caretEnd: bounds.start + hashtag.length
    };
  },
  formHashtag: function(text) {
    text = text.replace(/[\s,;:'"]/g, '');
    text = text.replace(/[.?!](?!$)/g, '');
    text = text.toLowerCase();
    return text = '#' + text;
  },
  updateDom: function(textInfo) {
    return setTimeout(function() {
      document.activeElement.value = textInfo.text;
      document.activeElement.selectionStart = textInfo.caretEnd;
      return document.activeElement.selectionEnd = textInfo.caretEnd;
    }, 0);
  },
  spliceStr: function(str, start, end, add) {
    return str.slice(0, start) + add + str.slice(end);
  },
  reverseStr: function(str) {
    return str.split('').reverse().join('');
  }
};

main.run();
