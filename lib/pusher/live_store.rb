# pusher = Pusher::Client.new

# store = pusher.live_store('object_name')
# store.set({})
# store.append(1)
# store["hello"] = "world"
# store.hset({hello: "world"})

module Pusher
	class LiveStore
		def initialize(name, app_id, host, port, scheme, pusher_client)
			@name = name
			@app_id = app_id
			@host = host
			@port = port
			@scheme = scheme
			@pusher_client = pusher_client
		end

		def set(data)
			body = {
				operation: "SET",
				data: data
			}
			send_request(body)
		end

		def append(list)
			body = {
				operation: "APPEND",
				data: (list.is_a?(Array) ? list : [list])
			}
			send_request(body)
		end

		def hset(key, value)
			body = {
				operation: "HSET",
				data: {
					key => value
				}
			}
			send_request(body)
		end

		alias_method :<<, :append
		alias_method :[]=, :hset

		private

		def send_request(body)
			Request.new(
				@pusher_client,
				:post,
				url,
				{},
				MultiJson.encode(body)
			).send_sync
		end

		def url
      URI.parse("#{@scheme}://#{@host}:#{@port}/apps/#{@app_id}/live-store/#{@name}")
		end
	end
end