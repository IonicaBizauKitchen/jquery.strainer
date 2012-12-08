# Split substring into words
String::looselyContains = (substring, delimiter=" ", strict=true) ->

  # Don't allow blanks words from untrimmed queries like "foo," or " bar"
  words = []
  for word in substring.split(delimiter)
    words.push word unless word is ""
  
  if strict
    # return true if ALL substrings are present
    for word in words
      return false unless @search(new RegExp(word, "i")) > -1
    return true
  else
    # return true if ANY substrings are present
    for word in words
      return true if @search(new RegExp(word, "i")) > -1
    return false

jQuery.fn.strainer = (options={}) ->
  
  # Bail if the strainer or selector doesn't exist
  return if this.length < 1
  return if $(options.selector).length < 1
  
  # selector
  # A CSS selector string like 'ul.things > li'
  this.data('selector', $(options.selector))
  
  # minChars
  # Minimum characters required before filtering is performed
  this.data('minChars', options.minChars or 1)
  
  # onStrain
  # Returns a collection of matching elements after each straining
  this.data('onStrain', options.onStrain)
  
  # mode
  # reductive: everything shows up until you start filtering
  # additive: nothing shows up until you start filtering
  this.data('mode', options.mode or 'reductive')

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
      words = q.split(' ')
      matching_words = []
      
      for word in words        
        # look for a key:value pair
        match = word.match(/(\w+):([\w,]+)/)
        
        # allow comma-delimited k:v values
        if match && $(this).data(match[1]) && $(this).data(match[1]).looselyContains(match[2], ",", false)
          matching_words.push word
        else if $(this).text().looselyContains(word)
          matching_words.push word
          
      $(this).toggleClass 'match', (matching_words.length is words.length)

    # Pass collection of matching elements to callback
    if this.data('onStrain')?
      this.data('onStrain')(this.data('selector').filter('.match'))