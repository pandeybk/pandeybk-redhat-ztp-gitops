oc exec -ti vault-server-0 -- vault operator init
oc exec -ti vault-server-0 -- vault operator unseal
oc exec -ti vault-server-1 -- vault operator raft join http://vault-server-0.vault-server-internal:8200
oc exec -ti vault-server-1 -- vault operator unseal
oc exec -ti vault-server-2 -- vault operator raft join http://vault-server-0.vault-server-internal:8200
oc exec -ti vault-server-2 -- vault operator unseal

oc exec -ti vault-server-0 -- vault login
oc exec -ti vault-server-0 -- vault operator raft list-peers

oc exec -ti vault-server-0 -- vault secrets enable -path=secret/ kv
oc exec -ti vault-server-0 -- vault kv put secret/openshiftpullsecret dockerconfigjson='{"auths":{"cloud.openshift.com":{"auth":"3BlbnNoaWZ0LXJl==","email":"example@redhat.com"},"quay.io":{"auth":"ZZMVhJRUJUR1I3WUwxN05VMQ==","email":"example@redhat.com"},"registry.connect.redhat.com":{"auth":"3BlbnNoaWZ0LXJl==","email":"example@redhat.com"},"registry.redhat.io":{"auth":"==","email":"example@redhat.com"}}}'

oc create secret generic vault-token --from-literal=token="s.XhitRtJcA8CVT7a9xfK804KT" -n vault 

Unseal Key 1: w/wo0NYvY4wYyykUOX/ankxBm3mrIoEnnrFPivZyoo33
Unseal Key 2: CgF455nzVmq4i0BVhZdZ3O8FiO0p+yBxpNBCJSfOoy8p
Unseal Key 3: UufT91fbNjDBlMrpIQSO66B2zJUg0KoriDuFJ+U44SPi
Unseal Key 4: KpNJ/3eMSQZYnmiBPr3Hdre9BOYaLfPetVpRFNUYOS9U
Unseal Key 5: 0FHMN/kjLgQY8ljhN+9xS5I4ZS3zG1vBYJYi9L5+/gWY

Initial Root Token: s.XhitRtJcA8CVT7a9xfK804KT