
import Foundation

struct NotificationModel: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    let data: [NotificationModelData]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, message, data
    }
}

// MARK: - Datum
struct NotificationModelData: Codable {
    let id, title, description, buttonAction: String?
    let timeAgo: String?
    let read: Bool?
    let courseID, sessionID, scheduleID, institutionCalendarID: String?
    let programID, yearNo, levelNo, term: String?
    let mergeStatus, sessionType, type: String?
    let session: NotificationSession?
    let rotation: String?
    let notificationType: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, description, buttonAction, timeAgo, read
        case courseID = "courseId"
        case sessionID = "sessionId"
        case scheduleID = "scheduleId"
        case institutionCalendarID = "institutionCalendarId"
        case programID = "programId"
        case yearNo, levelNo, term, mergeStatus, sessionType, type, session, rotation, notificationType
    }
}

// MARK: - Session
struct NotificationSession: Codable {
    let id: String?
    let end, start: NotificationSessionEnd

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case end, start
    }
}

// MARK: - End
struct NotificationSessionEnd: Codable {
    let hour, minute: Int
    let format: String
}
