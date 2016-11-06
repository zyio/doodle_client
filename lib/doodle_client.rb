require "doodle_client/version"
require 'nokogiri'
require 'mechanize'
require 'uri'
require 'net/http'

module DoodleClient

  def DoodleClient.urltoid(url)
    # If url doesn't have a / in it, assume it's already an id and return it.
    return url if !url.match("/")
    # If URL has http then id is 5th column, otherwise assuming 3rd.
    url.match("http") ? (id = url.split('/')[4]) : (id = url.split('/')[2])
    return id
  end

  def DoodleClient.verify(url)
    # Get an id to work with.
    id = urltoid(url)

    # Normal url for status code checking, invalid id on kissURL still returns
    # 200 for some reason.
    doodleURL = "http://doodle.com/poll/#{id}"

    # Use id to build doodle link we can parse on.
    kissURL = "http://doodle.com/kiss/#{id}?participantKey=&locale=en_US&timeZone=Europe%2FLondon"

    # Check we've got a valid doodle poll.
    status = Net::HTTP.get_response(URI("#{doodleURL}")).code
    return false if status != "200"
    return true

  end

  def DoodleClient.list(url)
    #Initialise empty options array. Could use a hash?
    options = Array.new

    # Get an id to work with.
    id = urltoid(url)

    agent = Mechanize.new
    agent.user_agent = "Windows Mozilla"

    # Use id to build doodle link we can parse on.
    kissURL = "http://doodle.com/kiss/#{id}?participantKey=&locale=en_US&timeZone=Europe%2FLondon"

    page = agent.get(kissURL)
    # Only gets checkboxes atm, should support radio buttons as well.
    page.forms[0].checkboxes.each{ |checkbox| options << checkbox  }

    return options
  end

  def DoodleClient.vote(url, name, options)
    # Get an id to work with.
    id = urltoid(url)

    agent = Mechanize.new
    agent.user_agent = "Windows Mozilla"

    # Use id to build doodle link we can parse on.
    kissURL = "http://doodle.com/kiss/#{id}?participantKey=&locale=en_US&timeZone=Europe%2FLondon"

    page = agent.get(kissURL)
    # Use provided name to vote.
    page.forms[0]["name"] = "#{name}"

    # Iterate over checkboxes and apply options array.
      page.forms[0].checkboxes.map{ |checkbox| checkbox.check if options.first == true; options.delete_at(0) }

    # Submit it.
    page.forms[0].submit
    return true
  end
end
