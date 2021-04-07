SSH config

```
Host grafana-dev
    ProxyCommand kubectl --kubeconfig=$HOME/.kube/config-grafana-us-central1 exec -i pods/christian-dev-0 -- /usr/sbin/sshd -i
    HostName grafana-dev
    User christian
    ServerAliveInterval 300
    ServerAliveCountMax 2
```
