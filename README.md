[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-meta.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-meta)
# Ansible role `meta`

An Ansible role for install and configure meta0, meta1 and meta2. Specifically, the responsibilities of this role are to:

- Install package
- Add specific configuration
- Add a watch file for conscienceagent

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_meta_bind_address` | `{{ hostvars[inventory_hostname]['ansible_' + openio_meta_bind_interface]['ipv4']['address'] }}` | Address IP to use. |
| `openio_meta_bind_interface` | `{{ ansible_default_ipv4.alias }}` | Interface to use |
| `openio_meta_location` | `"{{ ansible_hostname }}"` | Location |
| `openio_meta_type` | `meta0` | Service type to provide `[meta0, meta1, meta2]` |
| `openio_meta_namespace` | `"OPENIO"` | Namespace |
| `openio_meta_options` | `[]` | Specific options |
| `openio_meta_serviceid` | `"0"` | ID in gridinit |
| `openio_meta_version` | `latest` | Install a specific version |
| `openio_meta_volume` | `"/var/lib/oio/sds/{{ openio_meta_namespace }}/{{ openio_meta_type }}-{{ openio_meta_serviceid }}"` | Path to store data |

## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: all
  become: true
  vars:
    NS: OIO
  pre_tasks:
    - name: Ensures namespace directory exists
      file:
        dest: "/etc/oio/sds.conf.d"
        state: directory
      tags: install

    - name: Copy using the 'content' for inline data
      copy:
        content: |
          [{{ NS }}]
          # endpoints
          conscience=172.17.0.2:6000
          #zookeeper=172.17.0.2:6005
          proxy=172.17.0.2:6006
          event-agent=beanstalk://172.17.0.2:6014
          ns.meta1_digits=3
          udp_allowed=yes
          ns.storage_policy=THREECOPIES
          ns.chunk_size=10485760
          ns.service_update_policy=meta2=KEEP|3|1|;rdir=KEEP|3|1|;
        dest: "/etc/oio/sds.conf.d/{{ NS }}"
  roles:
    - role: repository
    - role: gridinit
      openio_gridinit_namespace: "{{ NS }}"
    - role: meta
      openio_meta_namespace: "{{ NS }}"
      openio_meta_type: meta2
      openio_meta_options:
        - meta2.outgoing.timeout.common.req=42.000000
```


```ini
[all]
node1 ansible_host=192.168.1.173
```

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome.
The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork.
Github can then easily create a PR based on that branch.

## License

Apache License, Version 2.0

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier) (maintainer)
