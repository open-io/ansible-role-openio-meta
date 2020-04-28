[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-meta.svg?branch=20.04)](https://travis-ci.org/open-io/ansible-role-openio-meta)
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
| `openio_meta_slots` | `[meta0]` | The service's slot in conscience |
| `openio_meta_version` | `latest` | Install a specific version |
| `openio_meta_volume` | `"/var/lib/oio/sds/{{ openio_meta_namespace }}/{{ openio_meta_type }}-{{ openio_meta_serviceid }}"` | Path to store data |
| `openio_meta_package_upgrade` | `false` | Set the packages to the latest version (to be set in extra_vars) |

## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: all
  become: true
  vars:
    NS: OIO

  roles:
    - role: users
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

GNU AFFERO GENERAL PUBLIC LICENSE, Version 3

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier) (maintainer)
