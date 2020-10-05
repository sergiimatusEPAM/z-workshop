# z-workshop

## install Concourse
There are few ways to make it:
1. Local - Docker-compose 
2. Cloud(AWS) - Helm-chart
https://github.com/concourse/concourse-chart
3. Cloud(AWS) - Control Tower using `bosh` cli
https://github.com/EngineerBetter/control-tower/blob/master/docs/prerequisites.md

AWS_ACCESS_KEY_ID=AKIA2AXT4FE6BQAMXX45 \
  AWS_SECRET_ACCESS_KEY=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 \
  control-tower deploy --iaas aws smatus-concourse-via-ct
  
### Prerequisites:
Use Homebrew to additionally install OpenSSL:
1. Install the Apple Command Line Tools:
`xcode-select --install`
2. Use Homebrew to additionally install OpenSSL:
`brew install openssl`

## Installation:
control-tower deploy --iaas aws smatus-concourse1
control-tower destroy --iaas aws smatus-concourse1