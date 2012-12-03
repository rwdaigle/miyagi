$ ->          

  class RepoMan
    
    @go: ->
      for url in @findUrlsInPage()
        console.log url
        $.getJSON url, (data) ->
          $('#repos').append HandlebarsTemplates.repo(data)
      
    @findUrlsInPage: ->      

      urls = []

      # Find all the links to github
      $("a[href*='github.com']").each ->

        # Extract user and repo from URL
        url = $(this).attr('href')
        match = url.match('//github.com/([-\sa-zA-Z]+)/([-\sa-zA-Z]+)')
    
        # Make sure it's a repo URL, and don't store dupes
        if match and match.length > 2
          url = "https://api.github.com/repos/" + match.slice(1,3).join("/")
          urls.push(url) unless urls.join('').match(url)

      return urls
  
  window.RepoMan = RepoMan
  
  # RepoMan.go()