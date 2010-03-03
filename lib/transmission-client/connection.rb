module Transmission
  class Connection
    include Singleton
    
    def init(host, port, username = "", password = "")
      @host = host
      @port = port
      @username = username unless username == ""
      @password = password unless password == ""
      @header = {}
      uri = URI.parse("http://#{@host}:#{@port}")
      Net::HTTP.start(uri.host, uri.port) do |http|
        @conn = http;
        resp = http.request(build_request(), build_json('session_get'))
        if resp.class == Net::HTTPUnauthorized
          raise SecurityError, 'The client was not able to authenticate, is your username or password wrong?'
        elsif resp.class == Net::HTTPConflict && @header['x-transmission-session-id'].nil?
          @header['x-transmission-session-id'] = resp['x-transmission-session-id']
        elsif resp.class == Net::HTTPOK
          true
        else
          false
        end
      end
    end
    
    def build_request()
      req = Net::HTTP::Post.new('/transmission/rpc')
      if @username != ""
        req.basic_auth @username, @password
      end
      if ! @header['x-transmission-session-id'].nil?
        req.add_field 'x-transmission-session-id', @header['x-transmission-session-id'] 
      end
      req
    end
    
    def request(method, attributes={})
      res = @conn.request(build_request, build_json(method, attributes)) 
      if res.class == Net::HTTPConflict && @header['x-transmission-session-id'].nil?
        @header['x-transmission-session-id'] = res['x-transmission-session-id']
        request(method,attributes)
      elsif res.class == Net::HTTPOK
        resp = JSON.parse(res.body)
        if resp["result"] == 'success'
          resp['arguments']
        else
          resp
        end
      else
        raise RuntimeError, 'Reponse received from the daemon was something transmission-client cant deal with! Panic!'
      end
    end
    
    def send(method, attributes={})
      data = request(method, attributes)['result']
      data.nil?
    end
    
    def build_json(method,attributes = {})
      if attributes.length == 0
        {'method' => method}.to_json
      else
       {'method' => method, 'arguments' => attributes }.to_json
      end
    end

  end
end