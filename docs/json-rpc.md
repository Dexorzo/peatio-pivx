# JSON RPC

The next list of JSON RPC calls where used for plugin development.
For response examples see spec/resources:

  * getbalance
  
    `curl  --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getbalance", "params": [] }' -H 'content-type: text/plain;' http://admin:changeme@127.0.0.1:51475`
  * getblock
  
    `curl  --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblock", "params": ["853a94e4a6aa61972dec6b78f828ab66bc93297692b60e430df9c7fff29ede70"] }' -H 'content-type: text/plain;' http://admin:changeme@127.0.0.1:51475`
  * getblockcount
  
    `curl  --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockcount", "params": [] }' -H 'content-type: text/plain;' http://admin:changeme@127.0.0.1:51475`
  * getblockhash
  
    `curl --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockhash", "params": [205324] }' -H 'content-type: text/plain;' http://admin:changeme@127.0.0.1:51475`
  * getnewaddress
  
    `curl --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnewaddress", "params": [] }' -H 'content-type: text/plain;' http://admin:changeme@127.0.0.1:51475`
  * listaddressgroupings
  
    `curl --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaddressgroupings", "params": [] }' -H 'content-type: text/plain;' http://admin:changeme@127.0.0.1:51475`
  * sendtoaddress
  
    `curl --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendtoaddress", "params": ["xzSCark5FXGWn96WCZE4sctCFQ5TonhmjD", 100.00] }' -H 'content-type: text/plain;' http://admin:changeme@127.0.0.1:51475`
  * methodnotfound
  
    `curl  --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "methodnotfound", "params": [] }' -H 'content-type: text/plain;' http://admin:changeme@127.0.0.1:51475`
