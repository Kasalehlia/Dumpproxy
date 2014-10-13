http = require 'http'
fs = require 'fs'

if process.argv.length < 5
	console.log "USAGE: #{process.argv[1]} <page URL> <file path> <port to listen>"
	return

server = http.createServer (req,res) ->
	request = http.get "#{process.argv[2]}#{req.url}", (ans) ->
		data = new Buffer parseInt ans.headers['content-length']
		count = 0

		ans.on 'data', (chunk) ->
			chunk.copy data, count
			count += chunk.length

		ans.on 'end', ->
			res.end data
			filename = "#{process.argv[3]}#{req.url}"
			if filename.slice -1 is '/'
				filename += 'index'
			path = req.url.substr(1).split '/'
			path.pop() # remove the file name
			done = -> fs.writeFileSync filename, data, {flag:'w+'}
			step = (i) ->
				if i is path.length
					done()
					return
				fs.mkdir "#{process.argv[3]}/#{path[..i].join('/')}", ->
					#ignore errors, since the directory may already exist
					step i+1
			step 0
	request.end()

server.listen parseInt process.argv[4]
