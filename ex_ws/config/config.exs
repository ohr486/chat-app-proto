use Mix.Config

config :chat, Chat.Endpoint,
  pubsub: [adapter: Phoenix.PubSub.Redis,
           host: System.get_env("REDIS_HOST") || "127.0.0.1",
           node_name: :chat_pubsub,
           pool_size: 1, name: :chat_pubsub]
