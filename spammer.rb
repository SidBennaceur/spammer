#!/usr/bin/env ruby

require "discordrb"

def read_parameters()
  content = JSON.parse(File.read("env.json"))
  return content[0]["channel"], content[0]["message"], content[0]["sleep_time"].to_i
end


def waiting_send(bot, channel, message, wait)
    # Wait the time before sending the message
    puts "I'm now waiting \033[92m#{wait}\033[0m secondes."
    sleep(wait)
    content = JSON.parse(File.read("env.json"))
    # Browse the list of server we are
    bot.servers.each do |serv_id, serv|
    # Browse channels on a server
        # Gets a random emoji to send in selected channel
        emote = serv.emoji.to_a[rand(0..erv.emoji.size())]
        serv.channels.each do |chan|
            # If the channel have the good name, we send the message
            if chan.id === content[0]["channel"].to_i
                # Send message
                puts "I'm sending the message `\033[94m#{message}\033[0m` the the channel \033[35m#{chan.name}\033[0m of the server \033[35m#{serv.name}\033[0m"
                bot.send_message(chan, emote)
            # Don't break, it may have multilple channels with the same name
            end
        end
    end
end


# Read secrets value
token = JSON.parse(File.read("secrets.json"))["discord"]
# Create the bot
bot = Discordrb::Bot.new(token: token)
bot.run(background: true)
puts "I'm logged in, this is my invite link \033[5:31m→\033[0m \033[93m#{bot.invite_url}\033[0m \033[5:31m←\033[0m"


# The infinite loop of the bot
while true
  # Read the configuration, it may change
  channel, message, wait = read_parameters()

  # Waid and send the message
  waiting_send(bot, channel,
