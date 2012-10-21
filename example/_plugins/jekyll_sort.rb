module Jekyll

  class DataSorter < Jekyll::Generator
    safe true
    priority :lowest

    def initialize(config)
    end

    def generate(site)
      config = site.config
      if !config['posts']
        postData = []
        site.posts.each { |post| 
          postHash = post.data
          postHash['url'] ||= post.url
          postHash['content'] ||= post.content
          postHash['date'] ||= post.date
          postData.push(postHash)
        }
        config['posts'] = postData
      end

      if !config['jekyll_sort']
        return
      end
      sort_jobs = config['jekyll_sort']
      ans = []
      sort_jobs.each do |job|
        data = config[job['src']]
        if job['by']
          ans = data.sort {|a,b| a[job['by']] <=> b[job['by']] }
        else
          ans = data.sort
        end

        case job['direction']
        when "down"
          ans.reverse!
        end

        config[job['dest']] = ans
      end
    end

  end

end
