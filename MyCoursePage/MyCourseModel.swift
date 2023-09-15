
import Foundation

//struct MyCourseData {
//    let topic: String?
//    let date: String?
//    let attendanceDetails: String?
//    let leave: String?
//    let sessionsComplete: String?
//    let progress: String?
//    let sessionsAttend:String?
//    let completed: String?
//}

// MARK: - Datum
struct Welcome: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    let data: [Datum]
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, message, data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let institutionCalendarID, programID, id, year: String?
    let level, term, courseCode, courseName: String?
    let courseType, startDate, endDate, programName: String?
    let rotation: String?
    let rotationCount: Int?
    var sessionData: BelowModelData?
    var downArrow = false
    enum CodingKeys: String, CodingKey {
        case institutionCalendarID = "_institution_calendar_id"
        case programID = "_program_id"
        case id = "_id"
        case year, level, term
        case courseCode = "course_code"
        case courseName = "course_name"
        case courseType = "course_type"
        case startDate = "start_date"
        case endDate = "end_date"
        case programName = "program_name"
        case rotation
        case rotationCount = "rotation_count"
    }
}

struct AcademicModel: Codable {
    let message: String
    let status, statusCode: Int
    let data: [AcademicData]
    
    enum CodingKeys: String, CodingKey {
        case message, status
        case statusCode = "status_code"
        case data
    }
}

// MARK: - Datum
struct AcademicData: Codable {
    let id, calendarName, endDate, startDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case calendarName = "calendar_name"
        case endDate = "end_date"
        case startDate = "start_date"
    }
}

struct BelowModel: Codable {
    let statusCode: Int
    let status: Bool
    let message: String
    let data: BelowModelData?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, message, data
    }
}

// MARK: - DataClass
struct BelowModelData: Codable {
    let absentCount, attendedSessions, leaveCount, permissionCount: Int
    let ondutyCount, presentCount, completedSessions, totalSessions: Int
    let warningData: String
    
}

