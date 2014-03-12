global.main =

  run: ->
    window.addEventListener 'keydown', (e) ->
      if e.which is 51 && e.shiftKey
        @hashtagify();

  hashtagify: ->
    return if document.activeElement.selectionStart isnt
        document.activeElement.selectionEnd
    inputTextInfo =
      text: document.activeElement.value,
      caretStart: document.activeElement.selectionStart
      caretEnd: document.activeElement.selectionEnd
    bounds = @getHashtagBounds(inputTextInfo)
    if bounds.start < bounds.end
      outputTextInfo = @getHashtaggedText(inputTextInfo, bounds)
      @updateDom(outputTextInfo)

  getHashtagBounds: (textInfo) ->
    text = textInfo.text.substring(0, textInfo.caretEnd)
    return {} if /\s$/.test(text) # can't start with a space
    singleLine = text.split('\n')[-1..][0] # get the last line of text
    lastHashtagDistance = @reverseStr(singleLine).search /\s*\S+#(\s|$)/
    lastHashtagDistance = singleLine.length if lastHashtagDistance is -1
    return {
      start: textInfo.caretEnd - lastHashtagDistance
      end: textInfo.caretEnd
    }

  getHashtaggedText: (textInfo, bounds) ->
    textToHashtag = textInfo.text.substring(bounds.start, bounds.end)
    hashtag = @formHashtag(textToHashtag)
    output = @spliceStr(textInfo.text, bounds.start, bounds.end, hashtag)
    return {
      text: output
      caretStart: bounds.start + hashtag.length
      caretEnd: bounds.start + hashtag.length
    }

  formHashtag: (text) ->
    text = text.replace(/[\s,;:'"]/g, '') # remove misc chars
    text = text.replace(/[.?!](?!$)/g, '') # remove non-terminating punctuation
    text = text.toLowerCase()
    text = '#' + text;

  updateDom: (textInfo) ->
    setTimeout ->
      document.activeElement.value = textInfo.text
      document.activeElement.selectionStart = textInfo.caretEnd
      document.activeElement.selectionEnd = textInfo.caretEnd
    , 0

  spliceStr: (str, start, end, add) ->
    str.slice(0, start) + add + str.slice(end)

  reverseStr: (str) ->
    str.split('').reverse().join('')

global.main.run();
