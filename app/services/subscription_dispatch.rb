class SubscriptionDispatch
  def notify_events_coming
    # query events that will happen in 3 days
    events =
      CharitableEvent
      .where('started_at > ? AND started_at < ?', Time.zone.now, Time.zone.now + 3.days)
      .includes(:favorite_users)
      .all
    events.each do |event|
      event.favorite_users.each do |user|
        message = <<~MSG
          您好，您訂閱的活動即將開始囉！
          活動名稱：#{event.name}
          活動時間：#{event.started_at.strftime('%Y/%m/%d %H:%M')}
          活動地點：#{event.location}
          活動連結：#{event.link}
        MSG
        LineNotify.send(user.line_notify_token, message:)
      end
    end
  end
end
