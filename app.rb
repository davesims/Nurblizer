require 'sinatra'

# configure block is a Sinatra feature
configure do
    @@nouns = File.open('nouns.txt').map{|line|
        line.strip.downcase
    }
end


def nurble(text)
    words = text.scan(/[A-Za-z]\w+/)
    text = text.upcase 
    
    (words - @@nouns).each do |w|
      text.gsub!(/(\b)#{w}(\b)/i, '\1<span class="nurble">nurble</span>\2')
    end
    
    text.gsub(/\n/, '<br>')
end


get "/" do
    haml :index
end


post "/nurble" do
    haml :nurble, :locals => {
      :text => nurble(params["text"])
    }
end
