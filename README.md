## Update

This fork of [poste.io](http://poste.io) was from a legacy branch. Nowadays it is wiser to use their latest version directly with `-e "DISABLE_CLAMAV=TRUE"` to achieve similar low memory usage levels with greater features. See [Documentation](https://poste.io/doc/)

## bekce/poste.io
Memory efficient (230-250 mb) complete multi-domain email server solution. 

[https://hub.docker.com/r/bekce/poste.io/](https://hub.docker.com/r/bekce/poste.io/)

[Poste.io](http://poste.io) is a complete mail server solution. 
With normal configuration, it takes around 700-750 mb of ram to run. However, the majority ram usage comes from `clamd`, which is an anti-virus service. This variation disables `clamd` and it now consumes only 230-250 mb of ram, which can easily fit into a 512 mb vps. 

Sample run command: 

```
docker run -d --restart=always \
    -p 25:25 -p 80:80 -p 443:443 -p 465:465 -p 587:587 -p 993:993 -p 995:995 \
    -v /etc/localtime:/etc/localtime:ro \
    -v /your-data-dir/data:/data \
    --name "mailserver" \
    bekce/poste.io
```

There are also 110 and 143 ports available but since those are plaintext versions of pop3 and imap, I don't recommend using them. 

After running, go to the address of the server, and use letsencrypt to get new certificates. Don't forget to generate and enter DKIM entries for your domains, good luck. 

*Security info:* This distribution comes with `clamd` disabled to save server memory, which can be vital for some people who absolutely want to virus scan their incoming emails. Normally, a really high portion of potentially dangerous emails including ones with executable attachments are automatically blocked by spamassassin and qpsmtpd configuration. 

*Memory usage output of a live system:*
```
[ec2-user@server ~]$ docker stats --no-stream
CONTAINER           CPU %               MEM USAGE / LIMIT       MEM %               NET I/O               BLOCK I/O           PIDS
e0dc81d9e0b8        0.01%               200.1 MiB / 995.4 MiB   20.11%              304.4 kB / 35.17 kB   103 MB / 532.5 kB   0
```
