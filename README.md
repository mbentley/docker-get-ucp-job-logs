docker-get-ucp-job-logs
=======================


Example usage:
```
docker run --rm \
  -e UCP_URL=ucp.example.com \
  -e USERNAME=username \
  -e PASSWORD=password \
  -e JOB_TYPE=ldap-sync \
  -e JOB_LIMIT=10 \
  -e JOB_INFO_ONLY=false \
  -e DEBUG=false \
  mbentley/get-ucp-job-logs
```

The following environment variables are required: `UCP_URL`, `USERNAME`, `PASSWORD`, `JOB_TYPE`. Valid types: any cleanup-db ldap-sync

If you wish to only have the high level job information returned, utilize `-e JOB_INFO_ONLY=true`.  For example, to return the job info from the last job ran of any type:


```
$ docker run --rm \
  -e UCP_URL=ucp.example.com \
  -e USERNAME=username \
  -e PASSWORD=password \
  -e JOB_TYPE=any \
  -e JOB_LIMIT=1 \
  -e JOB_INFO_ONLY=true \
  mbentley/get-ucp-job-logs
{
  "id": "b9f9acab-1dd8-4299-a53c-6b02ff8cb2b0",
  "workerID": "c0196a58-ff85-449d-baaf-0cfc5b144a43",
  "status": "error",
  "scheduledAt": "2017-12-15T22:00:00Z",
  "lastUpdated": "2017-12-15T22:00:10.174Z",
  "action": "ldap-sync",
  "args": [],
  "errorMessage": "process exited with error: exit status 1"
}
```

Get a specific job id's logs:

```
docker run --rm \
  -e UCP_URL=ucp.example.com \
  -e USERNAME=username \
  -e PASSWORD=password \
  -e JOB_INFO_ONLY=false \
  -e DEBUG=false \
  -e JOB_ID=eebf554d-e061-4d63-b910-5c4c5aa02083 \
  mbentley/get-ucp-job-logs
====== BEGIN job logs from eebf554d-e061-4d63-b910-5c4c5aa02083 ======
{
  "id": "eebf554d-e061-4d63-b910-5c4c5aa02083",
  "workerID": "c0196a58-ff85-449d-baaf-0cfc5b144a43",
  "status": "error",
  "scheduledAt": "2017-12-15T20:00:00Z",
  "lastUpdated": "2017-12-15T20:00:10.163Z",
  "action": "ldap-sync",
  "args": [],
  "errorMessage": "process exited with error: exit status 1"
}

{"level":"info","msg":"connecting to db ...","time":"2017-12-15T20:00:00Z"}
{"level":"debug","msg":"connecting to DB Addrs: [192.168.1.61:12383]","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"info","msg":"beginning sync of all user accounts","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"info","msg":"creating set of current users","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"current user: admin","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"skipping user with no LDAP DN: admin","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"current user: demo","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"current user: demo2","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"current user: dev1","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"current user: dev2","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"current user: ops1","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"current user: ops2","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"info","msg":"number of current users: 6","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"info","msg":"creating set of users found via LDAP search","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"info","msg":"Searching group: CN=docker-ee-users,CN=Users,DC=ad,DC=core,DC=dckrindy,DC=io for attr: member","time":"2017-12-15T20:00:00Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"debug","msg":"beginning search","searchURL":{"HostURLString":"ldap://ad.core.dckrindy.io","BaseDN":"CN=docker-ee-users,CN=Users,DC=ad,DC=core,DC=dckrindy,DC=io"},"time":"2017-12-15T20:00:00Z"}
{"error":"lookup ad.core.dckrindy.io on 192.168.1.50:53: read udp 172.17.0.12:39626-\u003e192.168.1.50:53: i/o timeout","go.version":"go1.8.3","hostURL":"ldap://ad.core.dckrindy.io","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"error","msg":"failed to connect to LDAP host","searchURL":{"HostURLString":"ldap://ad.core.dckrindy.io","BaseDN":"CN=docker-ee-users,CN=Users,DC=ad,DC=core,DC=dckrindy,DC=io"},"startTLS":"false","time":"2017-12-15T20:00:10Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"info","msg":"searching for users at ldap://ad.core.dckrindy.io","time":"2017-12-15T20:00:10Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"warning","msg":"unable to perform search on server \"ldap://ad.core.dckrindy.io\": unable to get LDAP server connection to ldap://ad.core.dckrindy.io (startTLS=false): lookup ad.core.dckrindy.io on 192.168.1.50:53: server misbehaving","time":"2017-12-15T20:00:10Z"}
{"go.version":"go1.8.3","instance.id":"112faf60-38b6-45c6-a5f8-458b24ef82d5","level":"fatal","msg":"unable to sync all users: unable to find LDAP users: search found no users","time":"2017-12-15T20:00:10Z"}
====== END job logs from eebf554d-e061-4d63-b910-5c4c5aa02083 ======
```
