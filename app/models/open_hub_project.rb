
require 'active_resource'
require 'json'

class MyXMLFormatter
  include ActiveResource::Formats::XmlFormat
  def decode(xml)
    ActiveResource::Formats::XmlFormat.decode(xml)['result']['project']
  end
end

class OpenHubProject < ActiveResource::Base
  include OpenHubProjectHelper

  attr_accessor :id, :name, :openhub_url, :description,
  :homepage_url, :logo_url, :tags, :vanity_url, :download_url

  self.site = "https://www.openhub.net/"
  self.format =  MyXMLFormatter.new
  self.element_name = "projects"
  @headers = { 'api_key' => "#{Rails.application.secrets.OPEN_HUB_KEY}" }


  #This method goes to Open Hub and return a project that was found by its id
  #calling example: OpenHubProject.find_by_id(1) (will find Apache Subversion)
  def self.find_by_id(id)
    params = {'api_key' => "#{Rails.application.secrets.OPEN_HUB_KEY}" }
    data = OpenHubProject.find(id, :params => params)
    project = OpenHubProject.build(data)
    project
  end

=begin
This method goes to OpenHub and return a project found by its name,
what can be a list as you may get multiple results.
=end
  def self.find_by_name(nome, list: false)
    #seting a params to be sent:
    params = {'query' => nome ,'api_key' => "#{Rails.application.secrets.OPEN_HUB_KEY}" }
    #asking OPenHub for a search:
    search = OpenHubProject.find(:all, :params => params)

    if list
      projects = search.collect do |data|
        OpenHubProject.build(data)
      end
    else
      data = search.first
      project = OpenHubProject.build(data)
      project
    end
  end

  #Sotores in a new instace of this model the info about an OpenHub project
  def self.build(data)
    project = OpenHubProject.new
    project.id = data.attributes["id"]
    project.name = data.attributes["name"]
    project.openhub_url = data.attributes["html_url"]
    project.download_url =  data.attributes["download_url"]

    project.description = data.attributes["description"]
    project.homepage_url = data.attributes["homepage_url"]
    project.logo_url = data.attributes["medium_logo_url"] || data.attributes["small_logo_url"]
    project.tags = data.attributes["tags"].attributes["tag"] if data.attributes["tags"]
    project.vanity_url = data.attributes["vanity_url"]
    project
  end


    def as_json(options={})
      {
        id: @id,
        name: @name,
        logo_url: @logo_url,
        tags: @tags,
        description: @description
      }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end
    private

    def params

    end


end
