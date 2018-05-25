#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests

@test 'Request stats throught the oioproxy' {
  run bash -c "curl http://172.17.0.2:6006/v3.0/forward/stats?id=172.17.0.2:6003"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'counter req.time' ]]
}

@test 'Specific options present' {
  run bash -c "docker exec -ti ${SUT_ID} cat /etc/oio/sds/TRAVIS/meta2-0/meta2-0.conf"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'meta2.outgoing.timeout.common.req=42.000000' ]]
}

@test 'Location by IP is dashed' {
  run bash -c "docker exec -ti ${SUT_ID} cat /etc/oio/sds/TRAVIS/watch/meta2-0.yml"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'location: 172-17-0-2' ]]
}
