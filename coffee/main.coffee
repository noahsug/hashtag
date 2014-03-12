global.main =

  run: ->
    window.addEventListener 'keydown', (e) ->
      if e.which is 51 && e.shiftKey
        @hashtagify();

  hashtagify: ->
    inputTextInfo =
      text: document.activeElement.value,
      caret: document.activeElement.selectionEnd
    bounds = @getHashtagBounds(inputTextInfo)
    if bounds.start < bounds.end
      outputTextInfo = @getHashtaggedText(inputTextInfo, bounds)
      @updateDom(outputTextInfo)

  getHashtagBounds: (textInfo) ->
    preCaretText = textInfo.text.substring(0, textInfo.caret)
    return {} if /\s$/.test(preCaretText) # can't start with a space
    singleLine = (split = preCaretText.split('\n'))[split.length - 1]
    lastHashtagDistance = @reverseStr(singleLine).search /\s*\S+#(\s|$)/
    lastHashtagDistance = singleLine.length if lastHashtagDistance is -1
    return {
      start: preCaretText.length - lastHashtagDistance
      end: preCaretText.length
    }

  getHashtaggedText: (textInfo, bounds) ->
    textToHashtag = textInfo.text.substring(bounds.start, bounds.end)
    hashtag = @formHashtag(textToHashtag)
    output = @spliceStr(textInfo.text, bounds.start, bounds.end, hashtag)
    return {
      text: output
      caret: bounds.start + hashtag.length
    }

  formHashtag: (text) ->
    text = text.replace(/[\s,#;:'"]/g, '') # remove misc chars
    text = text.replace(/[.?!](?!$)/g, '') # remove non-terminating punctuation
    text = text.toLowerCase()
    text = '#' + text;

  updateDom: (textInfo) ->
    setTimeout ->
      document.activeElement.value = textInfo.text
      document.activeElement.selectionStart = textInfo.caret
      document.activeElement.selectionEnd = textInfo.caret
    , 0

  spliceStr: (str, start, end, add) ->
    str.slice(0, start) + add + str.slice(end)

  reverseStr: (str) ->
    str.split('').reverse().join('')

global.main.run();
