# docker-shadowsocks

docker-shadowsocks is a Shadowsocks boxed in a Docker image built by [Tommy Lau](http://tommy.net.cn/).

## What is Shadowsocks?

[Shadowsocks](http://shadowsocks.org/) is a fast tunnel proxy that helps you bypass firewalls.

## What's included?

The latest shadowsocks-libev from official release and nothing more.

## How to use this image

Get the docker image by running the following commands:

```bash
docker pull tommylau/shadowsocks
```

Start an ocserv instance:

```bash
docker run -p [port]:[port] -d tommylau/shadowsocks -s 0.0.0.0 -p [port] -k [password] -m [method]
```

- `port` is the port you want the server to listen.
- `password` is the password
- `method` is the encrypt method

For a real world example with encrypt method `rc4-md5` with password `Passw0rd` on port `8338`:

```bash
docker run -p 8338:8338 -d tommylau/shadowsocks -s 0.0.0.0 -p 8338 -k Passw0rd -m rc4-md5
```

## Command line arguments for shadowsocks-libev

```
  usage:

    ss-[local|redir|server|tunnel]

       -s <server_host>           host name or ip address of your remote server

       -p <server_port>           port number of your remote server

       -l <local_port>            port number of your local server

       -k <password>              password of your remote server

       [-m <encrypt_method>]      encrypt method: table, rc4, rc4-md5,
                                  aes-128-cfb, aes-192-cfb, aes-256-cfb,
                                  bf-cfb, camellia-128-cfb, camellia-192-cfb,
                                  camellia-256-cfb, cast5-cfb, des-cfb, idea-cfb,
                                  rc2-cfb, seed-cfb, salsa20 and chacha20

       [-f <pid_file>]            the file path to store pid

       [-t <timeout>]             socket timeout in seconds

       [-c <config_file>]         the path to config file

       [-i <interface>]           network interface to bind,
                                  not available in redir mode

       [-b <local_address>]       local address to bind,
                                  not available in server mode

       [-u]                       enable udprelay mode,
                                  not available in redir mode

       [-L <addr>:<port>]         specify destination server address and port
                                  for local port forwarding,
                                  only available in tunnel mode

       [-d <addr>]                setup name servers for internal DNS resolver,
                                  only available in server mode

       [--fast-open]              enable TCP fast open,
                                  only available on Linux kernel > 3.7.0

       [--acl <acl_file>]         config file of ACL (Access Control List)
                                  only available in local mode

       [-v]                       verbose mode
```