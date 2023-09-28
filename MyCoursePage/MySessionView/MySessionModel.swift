import Foundation

// MARK: - MySessionCollection
struct MySessionCollection: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    let data: [MySessionCollectionData]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, message, data
    }
}

// MARK: - MySessionCollectionData
struct MySessionCollectionData: Codable {
    let name, type: String?
    let count: Int?
    var buttonSelected = false
    
    enum CodingKeys: String, CodingKey {
        case  name, type
        case count
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MySessionTable: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    let data: [MySessionTableData]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case status, message, data
    }
}

// MARK: - Datum
struct MySessionTableData: Codable {
    let id: String?
    let programID: String?
    let courseSessionDetails: [CourseSessionDetail]?
    let warningCount: Int?
    let warningData: String?
    let presentCount, absentCount, leaveCount: Int?
    let programName: String?
    let courseName: String?
    let courseCode: String?
    let totalSessions, completedSessions, attendedSessions: Int?
    let absentPercentage: Double?
    let year: String?
    let level: String?
    let term: String?
    let isActive: Bool?
    let sessions: [SessionElement]?
    let institutionCalendarID: String?
    let rotation: Rotation?
    let endDate, startDate, courseType: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case programID = "_program_id"
        case courseSessionDetails, warningCount, warningData, presentCount, absentCount, leaveCount
        case programName = "program_name"
        case courseName = "course_name"
        case courseCode = "course_code"
        case totalSessions, completedSessions, attendedSessions, absentPercentage, year, level, term, isActive, sessions
        case institutionCalendarID = "_institution_calendar_id"
        case rotation
        case endDate = "end_date"
        case startDate = "start_date"
        case courseType = "course_type"
    }
}

enum CourseCode: String, Codable {
    case cy8151 = "CY8151"
}

enum CourseName: String, Codable {
    case engineeringChemistry = "Engineering Chemistry"
}

// MARK: - CourseSessionDetail
struct CourseSessionDetail: Codable {
    let studentGroupName: String?
    let totalSessions, completedSessions, pendingSessions: Int?
    let courseSessions: [CourseSession]?
}

// MARK: - CourseSession
struct CourseSession: Codable {
    let deliveryName: String?
    let totalCount, completedCount, pendingCount: Int?
}

enum SessionType: String, Codable {
    case lecture = "Lecture"

}

enum StudentGroupNameElement: String, Codable {
    case fg1 = "FG-1"
    case mg1 = "MG-1"
}

enum ID: String, Codable {
    case the639054Ceb6505C32F2Be2C5A = "639054ceb6505c32f2be2c5a"
}

enum InstitutionCalendarID: String, Codable {
    case the6390B1F6B6505C97E1Be9337 = "6390b1f6b6505c97e1be9337"
}

enum Level: String, Codable {
    case level1 = "Level 1"
}

enum ProgramID: String, Codable {
    case the63904D24B6505C71D4Be15Ee = "63904d24b6505c71d4be15ee"
}

enum ProgramName: String, Codable {
    case electronicsANDCOMMUNICATIONENGINEERINGAtt = "ELECTRONICS AND COMMUNICATION ENGINEERING -Att"
    case electronicsANDCOMMUNICATIONENGINEERINGAttainment = "ELECTRONICS AND COMMUNICATION ENGINEERING-Attainment"
    case electronicsANDCOMMUNICATIONENGINEERINGAttainmentt = "ELECTRONICS AND COMMUNICATION ENGINEERING -Attainmentt"
    case programNameELECTRONICSANDCOMMUNICATIONENGINEERINGAttainment = "ELECTRONICS AND COMMUNICATION ENGINEERING -Attainment"
}

enum Rotation: String, Codable {
    case no = "no"
}

// MARK: - SessionElement
struct SessionElement: Codable {
    let sessionID: String?
    let sNo: Int?
    let deliverySymbol: String?
    let deliveryNo: Int?
    let sessionType: String?
    let sessionTopic: String?
    let mergeStatus: Bool?
    let status: AttendanceModeEnum?
    let studentGroups: [StudentGroup]?
    let scheduleID: String?
    let absentCount, leaveCount, warningCount, presentCount: Int?
    let totalSchedules: Int?
    let schedules: [Schedule]?
    let groupNames: [String]?
    let mergeWith: [MergeWith]?

    enum CodingKeys: String, CodingKey {
        case sessionID = "_session_id"
        case sNo = "s_no"
        case deliverySymbol = "delivery_symbol"
        case deliveryNo = "delivery_no"
        case sessionType = "session_type"
        case sessionTopic = "session_topic"
        case mergeStatus = "merge_status"
        case status
        case studentGroups = "student_groups"
        case scheduleID = "scheduleId"
        case absentCount, leaveCount, warningCount, presentCount, totalSchedules, schedules, groupNames
        case mergeWith = "merge_with"
    }
}

enum DeliverySymbol: String, Codable {
    case l = "L"
}

// MARK: - MergeWith
struct MergeWith: Codable {
    let id, scheduleID, sessionID: String?
    let session: MergeWithSession?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case scheduleID = "schedule_id"
        case sessionID = "session_id"
        case session
    }
}

// MARK: - MergeWithSession
struct MergeWithSession: Codable {
    let sessionID: String?
    let sNo: Int?
    let deliverySymbol: DeliverySymbol?
    let deliveryNo: Int?
    let sessionType: SessionType?
    let sessionTopic: String?

    enum CodingKeys: String, CodingKey {
        case sessionID = "_session_id"
        case sNo = "s_no"
        case deliverySymbol = "delivery_symbol"
        case deliveryNo = "delivery_no"
        case sessionType = "session_type"
        case sessionTopic = "session_topic"
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let id: String?
    let sessionDetail: SessionDetail?
    let zoomDetail: ZoomDetail?
    let teamsDetail: TeamsDetail?
    let rotation: Rotation?
    let mergeStatus: Bool?
    let status: String?
    let isDeleted, isActive: Bool?
    let remotePlatform: RemotePlatform?
    let institutionCalendarID: String?
    let programID: String?
    let programName: String?
    let type, term: String?
    let yearNo: String?
    let levelNo: String?
    let courseID: String?
    let courseName: String?
    let courseCode: String?
    let session: ScheduleSession?
    let studentGroups: [StudentGroup]?
    let scheduleDate: String?
    let start, end: End?
    let scheduleStartDateAndTime, scheduleEndDateAndTime: String?
    let mode: Mode?
    let subjects: [Subject]?
    let staffs: [Staff]?
    let students: [Student]?
    let infraID: InfraID?
    let infraName: String?
    let mergeWith: [MergeWith]?
    let scheduleInfraID: String?
    let isLive: Bool?
    let autoEndAttendanceIn: Int?
    let endDate, startDate: String?
    let studentsCount: Int?
    let retakeStatus: Int?
    let socketPort, uuid: String?
    let retakeDetails: RetakeDetails?
    let isMissedToComplete: Bool?
    let subType: String?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sessionDetail, zoomDetail, teamsDetail, rotation
        case mergeStatus = "merge_status"
        case status, isDeleted, isActive, remotePlatform
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
        case mergeWith = "merge_with"
        case scheduleInfraID = "infra_id"
        case isLive
        case autoEndAttendanceIn = "auto_end_attendance_in"
        case endDate = "end_date"
        case startDate = "start_date"
        case studentsCount, retakeStatus
        case socketPort = "socket_port"
        case uuid, retakeDetails, isMissedToComplete
        case subType = "sub_type"
    }
}

// MARK: - End
struct End: Codable {
    let hour, minute: Int?
    let format: Format?
}

enum Format: String, Codable {
    case am = "AM"
    case pm = "PM"
}

// MARK: - InfraID
struct InfraID: Codable {
    let id: String?
   // let zone: [JSONAny]?
    let buildingName, floorNo, roomNo, name: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
      //  case zone
        case buildingName = "building_name"
        case floorNo = "floor_no"
        case roomNo = "room_no"
        case name
    }
}

enum Mode: String, Codable {
    case onsite = "onsite"
    case remote = "remote"
}

enum RemotePlatform: String, Codable {
    case teams = "teams"
    case zoom = "zoom"
}

// MARK: - RetakeDetails
struct RetakeDetails: Codable {
    let scheduleID: [String]?
    let id, modeBy, staffID, status: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case scheduleID = "scheduleId"
        case id = "_id"
        case modeBy
        case staffID = "_staff_id"
        case status, createdAt
    }
}

// MARK: - ScheduleSession
struct ScheduleSession: Codable {
    let sessionID: String?
    let sNo: Int?
    let deliverySymbol: String?
    let deliveryNo: Int?
    let sessionType: String?
    let sessionTopic: String?
    let mergeStatus: Bool?
    let status: AttendanceModeEnum?
    let studentGroups: [StudentGroup]?
    let scheduleID: String?
    let mergeWith: [MergeWith]?

    enum CodingKeys: String, CodingKey {
        case sessionID = "_session_id"
        case sNo = "s_no"
        case deliverySymbol = "delivery_symbol"
        case deliveryNo = "delivery_no"
        case sessionType = "session_type"
        case sessionTopic = "session_topic"
        case mergeStatus = "merge_status"
        case status
        case studentGroups = "student_groups"
        case scheduleID = "scheduleId"
        case mergeWith = "merge_with"
    }
}

enum AttendanceModeEnum: String, Codable {
    case completed = "completed"
    case missed = "missed"
    case pending = "pending"
}

// MARK: - StudentGroup
struct StudentGroup: Codable {
    let id: String?
    let gender: Gender?
    let groupNo: Int?
    let groupName: String?
    let sessionGroup: [SessionGroup]?
    let groupID: String?
//    let students: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case gender
        case groupNo = "group_no"
        case groupName = "group_name"
        case sessionGroup = "session_group"
        case groupID = "group_id"
   //     case students
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

enum GroupID: String, Codable {
    case the6391A18D1Cb4A76Bc750B158 = "6391a18d1cb4a76bc750b158"
    case the6391A18D1Cb4A7A11050B15B = "6391a18d1cb4a7a11050b15b"
}

// MARK: - SessionGroup
struct SessionGroup: Codable {
    let id: String?
    let sessionGroupID: String?
    let groupNo: Int?
    let groupName: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sessionGroupID = "session_group_id"
        case groupNo = "group_no"
        case groupName = "group_name"
    }
}

enum SessionGroupGroupName: String, Codable {
    case the20252026EPRT1YEPRegulations20171LCY8151GL1 = "2025-2026-EP-RT-1Y-EP:Regulations 2017-1L-CY8151-G-L-1"
    case the20252026EPRT1YEPRegulations20171LCY8151GL2 = "2025-2026-EP-RT-1Y-EP:Regulations 2017-1L-CY8151-G-L-2"
}

enum SessionGroupID: String, Codable {
    case the6391A18D1Cb4A708C050B15A = "6391a18d1cb4a708c050b15a"
    case the6391A18D1Cb4A7810E50B15E = "6391a18d1cb4a7810e50b15e"
    case the6391A18D1Cb4A7Bc5850B15D = "6391a18d1cb4a7bc5850b15d"
}

// MARK: - SessionDetail
struct SessionDetail: Codable {
    let retake: Bool?
    let attendanceMode: String?
    let sessionDetailStartBy, startTime: String?
    let stopTime: StopTime?
    let startBy, mode: String?

    enum CodingKeys: String, CodingKey {
        case retake
        case attendanceMode = "attendance_mode"
        case sessionDetailStartBy = "startBy"
        case startTime = "start_time"
        case stopTime = "stop_time"
        case startBy = "_start_by"
        case mode
    }
}

enum StopTime: Codable {
    case integer(Int)
    case string(String)

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
        throw DecodingError.typeMismatch(StopTime.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StopTime"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Staff
struct Staff: Codable {
    let status: StaffStatus?
    let id: String?
    let staffName: StaffName?
    let staffID: String?
    let duration: String?

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case staffName = "staff_name"
        case staffID = "_staff_id"
        case duration
    }
}

// MARK: - StaffName
struct StaffName: Codable {
    let first, last: String?
    let middle: String?
    let family: String?
}

enum Family: String, Codable {
    case basha = "Basha"
    case empty = ""
    case family = "Family"
    case rizfame = "rizfame"
}

enum StaffStatus: String, Codable {
    case absent = "absent"
    case pending = "pending"
    case present = "present"
}

// MARK: - Student
struct Student: Codable {
    let id: String?
    let status: StaffStatus?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case status
    }
}

enum StudentID: String, Codable {
    case the61A61789B1723A7F23346F70 = "61a61789b1723a7f23346f70"
}

// MARK: - Subject
struct Subject: Codable {
    let id: String?
    let subjectID: String?
    let subjectName: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case subjectID = "_subject_id"
        case subjectName = "subject_name"
    }
}

enum SubjectID: String, Codable {
    case the63904Dc5B6505Cbdc7Be18D8 = "63904dc5b6505cbdc7be18d8"
    case the63904Dffb6505C63Ebbe1A7D = "63904dffb6505c63ebbe1a7d"
    case the63904E76B6505C4184Be1Ef2 = "63904e76b6505c4184be1ef2"
}

enum SubjectName: String, Codable {
    case engineeringChemistry = "Engineering chemistry"
    case engineeringGraphics = "Engineering graphics"
    case engineeringMathematics = "Engineering mathematics"
}

// MARK: - TeamsDetail
struct TeamsDetail: Codable {
    let meetingStatus: MeetingStatus?
    let teamsRecord: Bool?
    let teamMeetingID: String?
    let teamsStartURL: String?
    let teamsUserID, threadID, teamsTotalDuration: String?

    enum CodingKeys: String, CodingKey {
        case meetingStatus, teamsRecord
        case teamMeetingID = "teamMeetingId"
        case teamsStartURL = "teamsStartUrl"
        case teamsUserID = "teamsUserId"
        case threadID = "threadId"
        case teamsTotalDuration
    }
}

enum MeetingStatus: String, Codable {
    case completed = "completed"
    case notStarted = "Not Started"
}

enum Term: String, Codable {
    case regular = "regular"
}

enum Year: String, Codable {
    case year1 = "year1"
}

// MARK: - ZoomDetail
struct ZoomDetail: Codable {
    let meetingStatus: MeetingStatus?
    let passCode, zoomMeetingID: String?
    let zoomStartURL: String?
    let zoomUUID, zoomTotalDuration: String?

    enum CodingKeys: String, CodingKey {
        case meetingStatus, passCode
        case zoomMeetingID = "zoomMeetingId"
        case zoomStartURL = "zoomStartUrl"
        case zoomUUID = "zoomUuid"
        case zoomTotalDuration
    }
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
//
//class JSONCodingKey: CodingKey {
//    let key: String
//
//    required init?(intValue: Int) {
//        return nil
//    }
//
//    required init?(stringValue: String) {
//        key = stringValue
//    }
//
//    var intValue: Int? {
//        return nil
//    }
//
//    var stringValue: String {
//        return key
//    }
//}
//
//class JSONAny: Codable {
//
//    let value: Any
//
//    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//        return DecodingError.typeMismatch(JSONAny.self, context)
//    }
//
//    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//        return EncodingError.invalidValue(value, context)
//    }
//
//    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if container.decodeNil() {
//            return JSONNull()
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if let value = try? container.decodeNil() {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer() {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
//        if let value = try? container.decode(Bool.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Double.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(String.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decodeNil(forKey: key) {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
//        var arr: [Any] = []
//        while !container.isAtEnd {
//            let value = try decode(from: &container)
//            arr.append(value)
//        }
//        return arr
//    }
//
//    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
//        var dict = [String: Any]()
//        for key in container.allKeys {
//            let value = try decode(from: &container, forKey: key)
//            dict[key.stringValue] = value
//        }
//        return dict
//    }
//
//    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
//        for value in array {
//            if let value = value as? Bool {
//                try container.encode(value)
//            } else if let value = value as? Int64 {
//                try container.encode(value)
//            } else if let value = value as? Double {
//                try container.encode(value)
//            } else if let value = value as? String {
//                try container.encode(value)
//            } else if value is JSONNull {
//                try container.encodeNil()
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer()
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
//        for (key, value) in dictionary {
//            let key = JSONCodingKey(stringValue: key)!
//            if let value = value as? Bool {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Int64 {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Double {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? String {
//                try container.encode(value, forKey: key)
//            } else if value is JSONNull {
//                try container.encodeNil(forKey: key)
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer(forKey: key)
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
//        if let value = value as? Bool {
//            try container.encode(value)
//        } else if let value = value as? Int64 {
//            try container.encode(value)
//        } else if let value = value as? Double {
//            try container.encode(value)
//        } else if let value = value as? String {
//            try container.encode(value)
//        } else if value is JSONNull {
//            try container.encodeNil()
//        } else {
//            throw encodingError(forValue: value, codingPath: container.codingPath)
//        }
//    }
//
//    public required init(from decoder: Decoder) throws {
//        if var arrayContainer = try? decoder.unkeyedContainer() {
//            self.value = try JSONAny.decodeArray(from: &arrayContainer)
//        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
//            self.value = try JSONAny.decodeDictionary(from: &container)
//        } else {
//            let container = try decoder.singleValueContainer()
//            self.value = try JSONAny.decode(from: container)
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        if let arr = self.value as? [Any] {
//            var container = encoder.unkeyedContainer()
//            try JSONAny.encode(to: &container, array: arr)
//        } else if let dict = self.value as? [String: Any] {
//            var container = encoder.container(keyedBy: JSONCodingKey.self)
//            try JSONAny.encode(to: &container, dictionary: dict)
//        } else {
//            var container = encoder.singleValueContainer()
//            try JSONAny.encode(to: &container, value: self.value)
//        }
//    }
//}

