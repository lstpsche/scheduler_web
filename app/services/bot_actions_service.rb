# frozen_string_literal: true

class BotActionsService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def send_message(text)
    global_bot do |bot|
      message = bot.api.send_message(chat_id: user.id, text: text, reply_markup: nil, parse_mode: 'markdown')
      user.update(replace_last_message: false, last_message: message)
    end
  end

  private

  def global_bot
    Telegram::Bot::Client.run(ENV['SCHEDULER_BOT_TOKEN']) do |bot|
      yield(bot)
    end
  end
end
