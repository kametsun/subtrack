//
//  NotificationUtil.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/25.
//

import Foundation
import UserNotifications

func scheduleNotification(for subscription: Subscription, user: User) {
    guard let renewalDate = subscription.nextRenewalDate() else { return }

    // 日本時間のカレンダーを作成
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "Asia/Tokyo") ?? TimeZone.current

    // ユーザが設定した通知日数を引く
    var notificationDate = calendar.date(byAdding: .day, value: -user.notifyBeforeDays, to: renewalDate)!
    // 通知日の12:00に設定
    notificationDate = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: notificationDate)!

    let content = UNMutableNotificationContent()
    content.title = "\(subscription.name) Subscription Renewal"
    content.body = "Your subscription is renewing soon. Don't forget to check the details."
    content.sound = .default

    let triggerDate = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

    let request = UNNotificationRequest(identifier: subscription.id, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Failed to schedule notification: \(error.localizedDescription)")
        } else {
            print(
                "Notification scheduled for \(subscription.name) on"
                  + "\(notificationDate.description(with: Locale(identifier: "ja_JP")))"
            )
        }
    }

    // 保留中の通知リクエストを確認
    UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
        for request in requests {
            print("Pending notification: \(request)")
        }
    }
}
