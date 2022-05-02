require "jekyll"
require 'v8'
require 'json'

module Jekyll
  docs = Array.new
  myHash = Hash.new
  
  Jekyll::Hooks.register :site, :post_write do |site|

    #input values
    lunr_config_id = site.config["lunr_config_id"]
    lunr_config_boost = site.config["lunr_config_boost"]
    
    #This is specific to indexing with lunrjs
    #lunr_config_id = {:id => 'id'} # structure of index
    #lunr_config_boost= {:fields => {:title => 10, :tag => 20}} #structure for boost
    lunr_config = lunr_config_boost.merge(lunr_config_id)

    #The path to the files
    folder_root = site.source
    file_path = site.config['path_json'] #The path where it saves the json search file
    file_data_json = site.config['data_path_json'] #The path where it saves the json file with all data 
    folder_lunar_js = folder_root + '/_site/assets/js/lunr/lunr.js' # Path lunrjs
    folder_json = folder_root + '/_site/assets/json' #Path folder json files
    

    # Comprobamos que existe la carpeta de los jsons
    if !Dir.exist?(folder_json)
      Dir.mkdir(folder_json)
    end
    #Comprobamos que existe el fichero en la carpeta con el json indexado
    if file_path.nil?
      file_path = folder_json.to_s + '/search.json'
    end
    #Comprobamos que existe el fichero en la carpeta con el json de datos
    if file_data_json.nil?
      file_data_json = folder_json.to_s + '/data.json'
    end
    # Comprobamos que existe el lunarjs
    if !File.exist?(folder_lunar_js)
      raise "Could not find lunr.js into #{folder_lunar_js}"
    end

    cxt = V8::Context.new
    cxt.load(folder_lunar_js)
    # add new method to lunr index
    cxt.eval('lunr.Index.prototype.indexJson = function () {return JSON.stringify(this);}')
    #Get the lunjs object
    val = cxt.eval('lunr')
    #puts val.version
    #puts "### file_path  '#{file_path}'"
    #This is specific to 2.x versions.
    lunr_conf = proc do |this|
      this.ref('id')
      lunr_config[:fields].each_pair do |name, boost|
        this.field(name, {:boost => boost})
      end
      for page in site.pages
        if !page.data['metadata'].nil?  
          valor = page.data['metadata']
          tags_search =  valor['tags']
          tags_search.split(',').each do |tag_search|
            myHash = Hash[:id => page.url.to_s, :title => page.data['title'].to_s, :tag => tag_search.to_s, :summary => page.content.split(/[\r\n]+/).slice(0).gsub(/<\/?[^>]*>/, "")]
            #puts 'Name tag '+ tag_search
            #puts 'Url of site ' + page.url
            #puts 'Tags for search ' +valor[tag_search].to_s          
            this.add(myHash)
          end
          docs.push(myHash)
        end
      end
    end
    idx = val.call(lunr_conf)
    total = idx.indexJson()
    # Write the file index
    File.open(file_path, 'w') { |f| f.write(total) }
    # Write the file data
    File.open(file_data_json, 'w') { |f| f.write(docs.to_json) }
  end
end