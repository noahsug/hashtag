require '../nodejs_to_web/polyfill.coffee'
require '../coffee/main.coffee'

describe 'hashtag bookmarklet', ->

  beforeEach ->
    jasmine.Clock.useMock();

    @addMatchers
      toHashtagifyTo: (expected) ->
        document.activeElement.value = @actual.replace('|', '')
        document.activeElement.selectionEnd = @actual.indexOf('|')

        main.hashtagify()
        jasmine.Clock.tick(1);

        caret = document.activeElement.selectionEnd
        text = document.activeElement.value
        result = main.spliceStr(text, caret, caret, '|')

        @message = ->
          return 'Expected "' + @actual + '" to hashtagify to "' + expected +
              '", but it was "' + result + '"';
        return result is expected

  it 'hashtags text', ->
    expect('puppies|').toHashtagifyTo('#puppies|')

  it 'removes whitespace, quotes, punctuation, hashtags and caps', ->
    expect('"Oh...", said B#o#b.  That was silly#|').
        toHashtagifyTo('#ohsaidbobthatwassilly|')

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
