module Jekyll
  
  class DataSorter < Jekyll::Generator
    safe true
    priority :lowest
    
    def initialize(config)
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
    
    def generate(site)
      
    end
    
  end
  
end
