Gem::Specification.new do |s|
  s.name = 'message-sqs'
  s.version = '0.0.2'
  s.summary = 'Message SQS queue adapter.'
  s.description = <<-EOF
Hook up AWS SQS with Message background/asynchronous job processing mechanism.
EOF
  s.license = 'MIT'
  s.authors = ["Xiao Li"]
  s.email = ['swing1979@gmail.com']
  s.homepage = 'https://github.com/xli/message-sqs'

  s.add_runtime_dependency('aws-sdk', '~> 2')
  s.add_runtime_dependency('message', '>= 0.0.1')

  s.files = ['README.md']
  s.files += Dir['lib/**/*.rb']
end
