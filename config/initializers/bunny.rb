MQ_CLIENT = Bunny.new(logging: true, durable: true)

MQ_CLIENT.start

MQ = MQ_CLIENT.queue "registration"

