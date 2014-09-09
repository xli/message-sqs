# Message-SQS

Message provides flexible & reliable background/asynchronous job processing mechanism on top of simple queue interface.

Message-SQS hooks up AWS SQS with Message background/asynchronous job processing mechanism.


## Installation

    gem 'message-sqs'

## How to use

### Queuing jobs

Inspired by delayed_job API, call .enq.method(params) on any object and it will be processed in the background.

    # without message
    @img.resize(36)

    # with message
    @img.enq.resize(36)

### Start worker to process jobs

    Message.worker.start

## see https://github.com/xli/message for more details