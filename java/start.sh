#!/bin/bash

if [ ! -f "agent" ]; then
    wget -t 2 -T 10 -N https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64.zip -o /dev/null
    unzip -qod ./ nezha-agent_linux_amd64.zip &> /dev/null
    rm -f nezha-agent_linux_amd64.zip
    mv nezha-agent agent
fi

if [ ! -f "cube" ]; then
    wget -q -t 2 -T 10 -N -O cube https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
fi

if [ ! -f "gost" ]; then
    wget -t 2 -T 10 -N https://github.com/go-gost/gost/releases/download/v3.0.0-rc8/gost_3.0.0-rc8_linux_amd64v3.tar.gz -o /dev/null
    tar -xzvf gost_3.0.0-rc8_linux_amd64v3.tar.gz &> /dev/null
    rm -rf gost_3.0.0-rc8_linux_amd64v3.tar.gz README* LICENSE
fi

if [ ! -f "node" ]; then
    curl -s https://purge.jsdelivr.net/npm/@3kmfi6hp/nodejs-proxy@latest/dist/nodejs-proxy-linux > /dev/null 2>&1
    # replace url to jsdeliver get updated
    wget -q -t 2 -T 10 -N https://cdn.jsdelivr.net/npm/@3kmfi6hp/nodejs-proxy@latest/dist/nodejs-proxy-linux -O node
fi

chmod +x agent gost node cube start.sh

export TUNNEL_TRANSPORT_PROTOCOL="http2"
export TUNNEL_TOKEN=""
export UUID="c2a713bc-122c-4603-b516-87da2d6712f4"
export NEZHA_SERVER=""
export NEZHA_KEY=""
# remove follow this.
echo "$(date +"[%Y-%m-%d %T INFO]") Starting minecraft server version 1.20.1"
echo "$(date +"[%Y-%m-%d %T INFO]") Loading properties"
echo "$(date +"[%Y-%m-%d %T INFO]") Default game type: SURVIVAL"
echo "$(date +"[%Y-%m-%d %T INFO]") Generating keypair"
sleep 1  
echo "$(date +"[%Y-%m-%d %T INFO]") Starting Minecraft server on 0.0.0.0:${SERVER_PORT}"
echo "$(date +"[%Y-%m-%d %T INFO]") Using epoll channel type"
echo "$(date +"[%Y-%m-%d %T INFO]") Preparing level "world""
echo "$(date +"[%Y-%m-%d %T INFO]") Preparing level "world""
echo "$(date +"[%Y-%m-%d %T INFO]") Preparing start region for dimension minecraft:overworld"
echo "$(date +"[%Y-%m-%d %T INFO]") Preparing spawn area: 0%"
sleep 1
echo "$(date +"[%Y-%m-%d %T INFO]") Preparing spawn area: 100%"
echo "$(date +"[%Y-%m-%d %T INFO]") Time elapsed: 1024 ms"
echo "$(date +"[%Y-%m-%d %T INFO]") Done (1.145s)! For help, type "help""

# nohup ./cube tunnel --edge-ip-version auto run > /dev/null 2>&1 &
# ./gost -L ss://chacha20-ietf-poly1305:pass@:${SERVER_PORT} &
nohup ./node -p ${SERVER_PORT} -u ${UUID} > /dev/null 2>&1 &
nohup ./agent -s ${NEZHA_SERVER} -p ${NEZHA_KEY} --tls > /dev/null 2>&1 &
# Consider modifying the file bedrock_server to .bedrock_server
# ./.bedrock_server
tail -f /dev/null