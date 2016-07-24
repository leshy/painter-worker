require! {
  leshdash: { assign }
  bluebird: p
  ribcage
  'lweb3/transports/client/nssocket': { nssocketClient }
  'lweb3/protocols/query': query
  process
}

env = do
  settings:
    verboseInit: true
    name: 'unnamed'


ribcage.init env, (err,data) ->
  client = new nssocketClient assign env.settings.controler
  client.addProtocol new query.client()
  
  client.on 'end', ->
    env.log 'disconnected', {}, 'connection'
    process.exit 1
  
  client.connect!
  client.query do
    hi: env.settings.name,
    -> console.log "authenticated", it
