require '../nodejs_to_web/polyfill.coffee'
require '../coffee/main.coffee'

describe 'hashtag bookmarklet', ->

  beforeEach ->
    jasmine.Clock.useMock();

    @addMatchers
      toHashtagifyTo: (expected) ->
        document.activeElement.value = @actual.replace(/\|/g, '')
        document.activeElement.selectionStart = @actual.indexOf('|')
        document.activeElement.selectionEnd = @actual.lastIndexOf('|')

        main.hashtagify()
        jasmine.Clock.tick(1);

        caretStart = document.activeElement.selectionStart
        caretEnd = document.activeElement.selectionEnd
        text = document.activeElement.value
        result = main.spliceStr(text, caretEnd, caretEnd, '|')
        if caretStart isnt caretEnd
          result = main.spliceStr(result, caretStart, caretStart, '|')

        @message = ->
          return 'Expected "' + @actual + '" to hashtagify to "' + expected +
              '", but it was "' + result + '"';
        return result is expected

  it 'hashtags text', ->
    expect('puppies|').toHashtagifyTo('#puppies|')

  it 'removes whitespace, quotes, punctuation and caps', ->
    expect('"Oh...", said B#o#b.  That was silly#|').
        toHashtagifyTo('#ohsaidb#o#bthatwassilly#|')

  it 'does not remove terminating punctuation', ->
    expect('oh! you there?|').toHashtagifyTo('#ohyouthere?|')

  it 'properly moves the caret when hashtagging mid-sentance', ->
    expect('hey there| guy').toHashtagifyTo('#heythere| guy')

  it 'does not hashtagify after a space', ->
    expect('hey there |guy').toHashtagifyTo('hey there |guy')

  it 'hashtagifies only the current line', ->
    expect('oh\nhey there|').toHashtagifyTo('oh\n#heythere|')

  it 'does not hashtagify other hashtags', ->
    expect('#lolol i love cake|').toHashtagifyTo('#lolol #ilovecake|')
    expect('oh #hey there guy| #bob').toHashtagifyTo('oh #hey #thereguy| #bob')

  it 'does not hashtagify a text selection', ->
    expect('oh! |you there?|').toHashtagifyTo('oh! |you there?|')
