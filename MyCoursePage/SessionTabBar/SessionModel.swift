
import Foundation

struct SessionModel: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    let data: [SessionModelData]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, message, data
    }
}

// MARK: - Datum
struct SessionModelData: Codable {
    let schedules: [SessionSchedule]?
    let sessionID, deliverySymbol: String?
    let deliveryNo: Int?
    let sessionType, sessionTopic, programName, level: String?
    let year, term: String?
    let isActive, manualAttendance: Bool?
    var isSelected = false

    enum CodingKeys: String, CodingKey {
        case schedules
        case sessionID = "_session_id"
        case deliverySymbol = "delivery_symbol"
        case deliveryNo = "delivery_no"
        case sessionType = "session_type"
        case sessionTopic = "session_topic"
        case programName = "program_name"
        case level, year, term, isActive, manualAttendance
    }
}

// MARK: - Schedule
struct SessionSchedule: Codable {
    let id: String?
    let sessionDetail: SessionDetailData?
    let zoomDetail, teamsDetail: SessionDetails?
    let rotation: String?
    let mergeStatus: Bool?
    let status: String?
    let isActive: Bool?
    let remotePlatform: String?
    let retakeStatus: Int?
    let institutionCalendarID, programID, programName, type: String?
    let term, yearNo, levelNo, courseID: String?
    let courseName, courseCode: String?
    let session: SessionSession?
    let studentGroups: [SessionStudentGroup]?
    let scheduleDate: String?
    let start, end: SessionEnd?
    let scheduleStartDateAndTime, scheduleEndDateAndTime, mode: String?
    let subjects: [SessionSubject]?
    let staffs: [SessionStaff]?
    let students: [SessionStudent]?
    let infraID: SessionInfraID?
    let infraName: String?
    let socketPort, uuid: String?
    let isRetake: Bool?
    let courseType: String?
    let autoEndAttendanceIn: Int?
    let isMissedToSchedule: Bool?
    let subType: String?

    enum CodingKeys: String, CodingKey {
        case subType = "sub_type"
        case id = "_id"
        case sessionDetail, zoomDetail, teamsDetail, rotation
        case mergeStatus = "merge_status"
        case status, isActive, remotePlatform, retakeStatus
        case institutionCalendarID = "_institution_calendar_id"
        case programID = "_program_id"
        case programName = "program_name"
        case type, term
        case yearNo = "year_no"
        case levelNo = "level_no"
        case courseID = "_course_id"
        case courseName = "course_name"
        case courseCode = "course_code"
        case session
        case studentGroups = "student_groups"
        case scheduleDate = "schedule_date"
        case start, end, scheduleStartDateAndTime, scheduleEndDateAndTime, mode, subjects, staffs, students
        case infraID = "_infra_id"
        case infraName = "infra_name"
 //       case mergeWith = "merge_with"
        case socketPort = "socket_port"
        case uuid, isRetake, courseType
        case autoEndAttendanceIn = "auto_end_attendance_in"
        case isMissedToSchedule
    }
}

// MARK: - End
struct SessionEnd: Codable {
    let hour, minute: Int?
    let format: String?
}

// MARK: - InfraID
struct SessionInfraID: Codable {
    let id: String?
    let buildingName, floorNo, roomNo, name: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case buildingName = "building_name"
        case floorNo = "floor_no"
        case roomNo = "room_no"
        case name
    }
}

// MARK: - Session
struct SessionSession: Codable {
    let deliverySymbol: String?
    let deliveryNo: Int?
    let sessionType, sessionTopic: String?

    enum CodingKeys: String, CodingKey {
        case deliverySymbol = "delivery_symbol"
        case deliveryNo = "delivery_no"
        case sessionType = "session_type"
        case sessionTopic = "session_topic"
    }
}

// MARK: - SessionDetail
struct SessionDetailData: Codable {
    let attendanceMode, startBy, startTime: String?
    let stopTime: BasicType?
    enum CodingKeys: String, CodingKey {
        case attendanceMode = "attendance_mode"
        case startBy
        case startTime = "start_time"
        case stopTime = "stop_time"
    }
}

// MARK: - Staff
struct SessionStaff: Codable {
    let status: String?
    let staffName: StaffName?
    let staffID: String?

    enum CodingKeys: String, CodingKey {
        case status
        case staffName = "staff_name"
        case staffID = "_staff_id"
    }
}

// MARK: - StaffName
struct SessionStaffName: Codable {
    let first, last, middle, family: String?
}

// MARK: - StudentGroup
struct SessionStudentGroup: Codable {
    let groupName: String?
    let sessionGroup: [SessionGroup]?

    enum CodingKeys: String, CodingKey {
        case groupName = "group_name"
        case sessionGroup = "session_group"
    }
}

// MARK: - SessionGroup
struct SessionSessionGroup: Codable {
    let groupName: String?

    enum CodingKeys: String, CodingKey {
        case groupName = "group_name"
    }
}

// MARK: - Student
struct SessionStudent: Codable {
    let status, primaryStatus, id, time: String?

    enum CodingKeys: String, CodingKey {
        case status, primaryStatus
        case id = "_id"
        case time
    }
}

// MARK: - Subject
struct SessionSubject: Codable {
    let subjectName: String?

    enum CodingKeys: String, CodingKey {
        case subjectName = "subject_name"
    }
}

// MARK: - Detail
struct SessionDetails: Codable {
}

enum BasicType: Codable {
    case integer(Int)
    case string(String)
    case double(Double)
    case long(Int64)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Int64.self) {
            self = .long(x)
            return
        }
        throw DecodingError.typeMismatch(BasicType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Rating"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .long(let x):
            try container.encode(x)
        }
    }
}
