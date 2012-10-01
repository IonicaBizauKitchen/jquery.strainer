# Split substring on space, return true if all resulting substrings are present
String::looselyContains = (substring) ->
  words = substring.split(' ')
  for word in words
    return false unless @search(new RegExp(word, "i")) > -1
  true

jQuery.fn.strainer = (options) ->
  
  # Bail if the strainer or selector doesn't exist
  return if this.length < 1
  return if $(options.selector).length < 1
  
  # selector
  # A CSS selector string like 'ul.things > li'
  this.data('selector', $(options.selector))

  # mode
  # reductive: everything shows up until you start filtering
  # additive: nothing shows up until you start filtering
  this.data('mode', options.mode or 'reductive')
  
  # minChars
  # Minimum characters required before filtering is performed
  this.data('minChars', options.minChars or 1)

  # Show or hide all the things, depending on mode
  if this.data('mode') is 'reductive'
    this.data('selector').addClass('match')
  else
    this.data('selector').removeClass('match')

  this.keyup (event) =>
    q = this.val()
    
    # If the query is too short (or empty)
    if q.length < this.data('minChars')
      if this.data('mode') is 'reductive'
        this.data('selector').addClass('match') # Show all
      else
        this.data('selector').removeClass('match') # Hide all
      return
    
    this.data('selector').each ->
      if $(this).text().looselyContains(q)
        $(this).addClass('match')
      else
        $(this).removeClass('match')