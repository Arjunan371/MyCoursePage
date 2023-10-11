import Foundation

class MyCourseVieModel {
    var courseData: [Datum] = []
    var academicData:[AcademicData] = []
    var dataCourseListModel: [Datum] = []
    var myCourseBelowData: BelowModelData?
    var showIndicator: (() -> ())?
    var showAcademicDataIndicator: (() -> ())?
    var filterButtonIndex = 4
    var sideMenuShow = false
    //  var buttonTitles: [String] = ["Today","Lecture","Event","Support Session","All"]
    // loadAcademicData()?.data ??
    //    var topic:[String] = ["Course Code - Course 1","Course Code - Course 1","Course Code - Course 1"]
    //    var date:[String] = ["Level 3 / Jan 5, 2021 - Feb 26, 2021","Level 3 / Jan 5, 2021 - Feb 26, 2021","Level 3 / Jan 5, 2021 - Feb 26, 2021"]
//        var attendanceDetails:[String] = ["L1 - Unit1 - Unit title Introduction To","L2 - Unit1 - Unit title Introduction Tos","L3 - Unit1 - Unit title Introduction To the swiftUI"]
//        var leave:[String] = ["MG-1(L1)","MG-1(L1)","MG-1(L1)"]
//        var sessionsComplete:[String] = ["Engineering chemistry . remote .Teams 2nd year","Engineering chemistry . onsite .Ahmed","Engineering chemistry . remote .abu zoom"]
//        var progress:[String] = ["Completed","Completed","Completed"]
//        var sessionsAttend:[String] = ["20 Dec 2025, 3.15 pm - 3.30 pm","20 Dec 2022, 3.15 pm - 3.30 pm","20 Dec 2022, 3.15 pm - 3.30 pm"]
//        var completed:[String] = ["absent","absent","absent"]
//        func forAppendDataInModel() {
//            for i in 0..<leave.count {
//                let courseData = MyCourseData( attendanceDetails: attendanceDetails[i], leave: leave[i], sessionsComplete: sessionsComplete[i], progress: progress[i],sessionsAttend: sessionsAttend[i],completed: completed[i])
//                myCourseModel.append(courseData)
//            }
//            print(myCourseModel)
//        }
    
    
    func forFilterButtonIndex(){
    //    dataCourseListModel.removeAll()
        let currentDate = Date.getCurrentDate()
        var filterArray: [Datum] = []
        switch filterButtonIndex {
        case 1:
            filterArray = courseData.filter({ currentDate < $0.startDate ?? ""})
       
        case 2:
            filterArray = courseData.filter({ currentDate > $0.endDate ?? ""})

        case 3:
            filterArray = courseData.filter({ $0.startDate ?? "" < currentDate && currentDate < $0.endDate ?? ""})
   
        case 4:
            filterArray = courseData.compactMap({$0})

        default:
            break
        }
        dataCourseListModel.append(contentsOf: filterArray)
    }
    
    func filteredData(searchText: String = "") {
        let currentDate = Date.getCurrentDate()
        var filterArray: [Datum] = courseData
        switch filterButtonIndex {
        case 1:
            filterArray = courseData.filter({ currentDate < $0.startDate ?? ""})
    
        case 2:
            filterArray = courseData.filter({ currentDate > $0.endDate ?? ""})

        case 3:
            filterArray = courseData.filter({ $0.startDate ?? "" < currentDate && currentDate < $0.endDate ?? ""})
       
        case 4:
            filterArray = courseData.compactMap({$0})

        default:
            break
        }
        if searchText.isEmpty {
            dataCourseListModel = filterArray.compactMap({$0})
        } else {
            dataCourseListModel = filterArray.filter({ element in
                "\(element.courseName ?? "")".lowercased().contains(searchText.lowercased()) == true ||
                "\(element.level ?? "")".lowercased().contains(searchText.lowercased()) == true ||
                    "\(element.term ?? "")".lowercased().contains(searchText.lowercased()) == true ||
                    "\(element.startDate ?? "")".lowercased().contains(searchText.lowercased()) == true || "\(element.endDate ?? "")".lowercased().contains(searchText.lowercased()) == true
                })
        }
        
    }
    
    func indexOf(course: Datum) -> Int? {
        courseData.lastIndex(where: { $0.id == course.id && $0.term == course.term})
    }
    
    func updateSessionData(data: BelowModelData, course: Datum) {
        if let index = indexOf(course: course) {
            courseData[index].sessionData = data
        }
    }
    
    func forInitialApiIntegration(academicModel:AcademicData? = nil,completion: (() -> Void)? = nil){
        let orginalURL = "https://ecs-dsapi-staging.digivalitsolutions.com/api/v1/digiclass/course_session/userCourses/61a61789b1723a7f23346f70?institutionCalendarId=\(academicModel?.id ?? "6390b1f6b6505c97e1be9337")&type=student"
        
        guard let url = URL(string: orginalURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {return}
        print("url==>",url)
        showAcademicDataIndicator?()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "AUthorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJEMDAxMiIsImlhdCI6MTY5NzAwMTY0OSwiZXhwIjoxNjk3MDM3NjQ5fQ.ICLubI_GSpOijO4TgOL--p4TAT_nrwk5Z4SSXlTI4vg"
        ]
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {(data,response,error) in
            if error == nil {
                do{
                    let decoder = JSONDecoder()
                    guard let getdata = data else {return}
                   let jasonvalue = try? decoder.decode(Welcome.self, from: getdata)
                    if let datas = jasonvalue {
                        self.courseData = datas.data
                       
                    }
                        DispatchQueue.main.async {
                            completion?()
                        }
                } catch{
                    print("thanks for giving the error")
                }
            }
        }
        dataTask.resume()
    }
        
    func forApiIntegration(course: Datum,completion: (() -> Void)? = nil ) {
        var orginalURL = "https://ecs-dsapi-staging.digivalitsolutions.com/api/v1/digiclass/course_session/userCourseSessionDetails/61a61789b1723a7f23346f70/\(course.id ?? "")?institutionCalendarId=\(course.institutionCalendarID ?? "")&type=student&level=\(course.level ?? "")&term=\(course.term ?? "")"
        if course.rotation == "yes" {
            orginalURL += "&rotationCount=\(course.rotationCount ?? 0)"
        }
        
        guard let url = URL(string: orginalURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {return}
        print(url)
        showIndicator?()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "AUthorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJEMDAxMiIsImlhdCI6MTY5NzAwMTY0OSwiZXhwIjoxNjk3MDM3NjQ5fQ.ICLubI_GSpOijO4TgOL--p4TAT_nrwk5Z4SSXlTI4vg"
        ]
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {(data,response,error) in
            if error == nil {
                do{
                    let decoder = JSONDecoder()
                    guard let getdata = data else {return}
                    let jasonvalue = try decoder.decode(BelowModel.self, from: getdata)
                    if let datas = jasonvalue.data {
        
                        DispatchQueue.main.async {
                            self.updateSessionData(data: datas, course: course)
                            completion?()
                        }
                    }
                } catch{
                    print("thanks for giving the error")
                }
            }
        }
        dataTask.resume()
    }
    
    func academicYearApiIntegration(completion: (() -> Void)? = nil){
        let orginalURL = "https://ecs-dsapi-staging.digivalitsolutions.com/api/v1/institution_calendar/calendars"
        
        guard let url = URL(string: orginalURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {return}
        showAcademicDataIndicator?()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "_user_id": "61a61789b1723a7f23346f70",
            "_institution_id": "5e5d0f1a15b4d600173d5692",
            "Content-Type": "application/json; charset=utf-8",
            "AUthorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJEMDAxMiIsImlhdCI6MTY5NzAwMTY0OSwiZXhwIjoxNjk3MDM3NjQ5fQ.ICLubI_GSpOijO4TgOL--p4TAT_nrwk5Z4SSXlTI4vg"
        ]
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {(data,response,error) in
            if error == nil {
                do{
                    let decoder = JSONDecoder()
                    guard let getdata = data else {return}
                   let jasonvalue = try? decoder.decode(AcademicModel.self, from: getdata)
                    if let datas = jasonvalue {
                        self.academicData = datas.data
                    }
                        DispatchQueue.main.async {
                            completion?()
                        }
                } catch{
                    print("thanks for giving the error")
                }
            }
        }
        dataTask.resume()
    }
    
}


extension MyCourseVieModel {
    
//    static func loadMockData() -> Welcome? {
//        let decoder = JSONDecoder()
//        let jsonString = """
//{
//    "status_code": 200,
//    "status": true,
//    "message": "Data retrieved",
//    "data": [
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6488363dd0994fe7127b34ec",
//            "_id": "648838d2d0994f9f6b7b3ecb",
//            "year": "year6",
//            "level": "Level 10",
//            "term": "regular",
//            "course_code": "Med 406",
//            "course_name": "Medicine",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-09-25T00:00:00.000Z",
//            "program_name": "Demo_Medicine2",
//            "rotation": "yes",
//            "rotation_count": 1
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "64cc89d3cdc4f7473f0397c0",
//            "_id": "64d3c721e2b8b442a6295637",
//            "year": "year3",
//            "level": "Level 5",
//            "term": "regular",
//            "course_code": "IBLS 3055",
//            "course_name": "Immune, Blood and Lymphatic System",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-10-30T00:00:00.000Z",
//            "program_name": "Medicine Unit",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "64cc89d3cdc4f7473f0397c0",
//            "_id": "64d3c721e2b8b40399295643",
//            "year": "year3",
//            "level": "Level 5",
//            "term": "regular",
//            "course_code": "SERV 3055",
//            "course_name": "Elective Community Service-2",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-10-30T00:00:00.000Z",
//            "program_name": "Medicine Unit",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "64cc89d3cdc4f7473f0397c0",
//            "_id": "64d3c721e2b8b4a7bf29564f",
//            "year": "year3",
//            "level": "Level 5",
//            "term": "regular",
//            "course_code": "CVS 3055",
//            "course_name": "Cardiovascular System",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-10-30T00:00:00.000Z",
//            "program_name": "Medicine Unit",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "64cc89d3cdc4f7473f0397c0",
//            "_id": "64d3c721e2b8b4954f29565b",
//            "year": "year3",
//            "level": "Level 5",
//            "term": "regular",
//            "course_code": "RES 3055",
//            "course_name": "Respiratory System",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-10-30T00:00:00.000Z",
//            "program_name": "Medicine Unit",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "642fd8a873ed130e547712ba",
//            "_id": "642fe62222aa3fe3200ba7e1",
//            "year": "year1",
//            "level": "Level 1",
//            "term": "regular",
//            "course_code": "HS31512",
//            "course_name": "Professional English - I",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-11-27T00:00:00.000Z",
//            "program_name": "INFORMATION TECHNOLOGY 2.0",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "63904d24b6505c71d4be15ee",
//            "_id": "639054ceb6505c32f2be2c5a",
//            "year": "year1",
//            "level": "Level 1",
//            "term": "regular",
//            "course_code": "CY8151",
//            "course_name": "Engineering Chemistry",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-12-11T00:00:00.000Z",
//            "program_name": "ELECTRONICS AND COMMUNICATION ENGINEERING-Attainment",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6488363dd0994fe7127b34ec",
//            "_id": "648838d2d0994f04647b3cbf",
//            "year": "year2",
//            "level": "Level 3",
//            "term": "regular",
//            "course_code": "ANAT 203",
//            "course_name": "Basic Human Anatomy",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-12-11T00:00:00.000Z",
//            "program_name": "Demo_Medicine2",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "63904d24b6505c71d4be15ee",
//            "_id": "639054ceb6505cd718be2d5f",
//            "year": "year3",
//            "level": "Level 5",
//            "term": "regular",
//            "course_code": "EC8501",
//            "course_name": "Digital Communication",
//            "course_type": "standard",
//            "start_date": "2025-06-08T00:00:00.000Z",
//            "end_date": "2025-12-18T00:00:00.000Z",
//            "program_name": "ELECTRONICS AND COMMUNICATION ENGINEERING -Attainmentt",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6488363dd0994fe7127b34ec",
//            "_id": "648838d2d0994fdf107b3ed8",
//            "year": "year6",
//            "level": "Level 10",
//            "term": "regular",
//            "course_code": "Sur 405",
//            "course_name": "Surgery 1",
//            "course_type": "standard",
//            "start_date": "2025-09-28T00:00:00.000Z",
//            "end_date": "2026-01-22T00:00:00.000Z",
//            "program_name": "Demo_Medicine2",
//            "rotation": "yes",
//            "rotation_count": 1
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6489530561cdb34818cda1d1",
//            "_id": "6489550a61cdb3ef62cda637",
//            "year": "year1",
//            "level": "Level 2",
//            "term": "regular",
//            "course_code": "CHEM102",
//            "course_name": "Chemistry for Health Sciences",
//            "course_type": "standard",
//            "start_date": "2025-11-23T00:00:00.000Z",
//            "end_date": "2026-02-19T00:00:00.000Z",
//            "program_name": "Foundation_Demo_A",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6489530561cdb34818cda1d1",
//            "_id": "6489550a61cdb3437dcda627",
//            "year": "year1",
//            "level": "Level 2",
//            "term": "regular",
//            "course_code": "ARAB101",
//            "course_name": "Medical Terminology",
//            "course_type": "standard",
//            "start_date": "2025-11-23T00:00:00.000Z",
//            "end_date": "2026-04-02T00:00:00.000Z",
//            "program_name": "Foundation_Demo_A",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6489530561cdb34818cda1d1",
//            "_id": "6489550a61cdb32460cda62f",
//            "year": "year1",
//            "level": "Level 2",
//            "term": "regular",
//            "course_code": "ENGL102",
//            "course_name": "English for Academic Purposes-2",
//            "course_type": "standard",
//            "start_date": "2025-11-23T00:00:00.000Z",
//            "end_date": "2026-04-02T00:00:00.000Z",
//            "program_name": "Foundation_Demo_A",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6489530561cdb34818cda1d1",
//            "_id": "6489550a61cdb3aeb7cda63f",
//            "year": "year1",
//            "level": "Level 2",
//            "term": "regular",
//            "course_code": "ARAB102",
//            "course_name": "Arabic Language",
//            "course_type": "standard",
//            "start_date": "2026-01-11T00:00:00.000Z",
//            "end_date": "2026-04-02T00:00:00.000Z",
//            "program_name": "Foundation_Demo_A",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6488363dd0994fe7127b34ec",
//            "_id": "648838d2d0994f36b87b3ee5",
//            "year": "year6",
//            "level": "Level 10",
//            "term": "regular",
//            "course_code": "Ped 404",
//            "course_name": "Pediatrics",
//            "course_type": "standard",
//            "start_date": "2026-01-25T00:00:00.000Z",
//            "end_date": "2026-05-21T00:00:00.000Z",
//            "program_name": "Demo_Medicine2",
//            "rotation": "yes",
//            "rotation_count": 1
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6489530561cdb34818cda1d1",
//            "_id": "6489550a61cdb392e6cda647",
//            "year": "year1",
//            "level": "Level 3",
//            "term": "regular",
//            "course_code": "EDU102",
//            "course_name": "Communication Skills",
//            "course_type": "standard",
//            "start_date": "2026-04-19T00:00:00.000Z",
//            "end_date": "2026-05-28T00:00:00.000Z",
//            "program_name": "Foundation_Demo_A",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6489530561cdb34818cda1d1",
//            "_id": "6489550a61cdb3358ecda64f",
//            "year": "year1",
//            "level": "Level 3",
//            "term": "regular",
//            "course_code": "ISLM102",
//            "course_name": "Islamic Ethics",
//            "course_type": "standard",
//            "start_date": "2026-04-19T00:00:00.000Z",
//            "end_date": "2026-05-28T00:00:00.000Z",
//            "program_name": "Foundation_Demo_A",
//            "rotation": "no"
//        },
//        {
//            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
//            "_program_id": "6489530561cdb34818cda1d1",
//            "_id": "6489550a61cdb3236fcda657",
//            "year": "year1",
//            "level": "Level 3",
//            "term": "regular",
//            "course_code": "BIOL102",
//            "course_name": "Cell Biology and Genetics",
//            "course_type": "standard",
//            "start_date": "2026-04-19T00:00:00.000Z",
//            "end_date": "2026-05-28T00:00:00.000Z",
//            "program_name": "Foundation_Demo_A",
//            "rotation": "no"
//        }
//    ]
//}
//"""
//
//        let jsonData = Data(jsonString.utf8)
//        do {
//            let response = try decoder.decode(Welcome.self, from: jsonData)
//
//            return response
//        } catch DecodingError.keyNotFound(let key, let context) {
//            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
//        } catch DecodingError.valueNotFound(let type, let context) {
//            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
//        } catch DecodingError.typeMismatch(let type, let context) {
//            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
//        } catch DecodingError.dataCorrupted(let context) {
//            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
//        } catch let error as NSError {
//            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
//        }
//        return nil
//    }
    
//    static func loadAcademicData() -> AcademicModel? {
//        let decoder = JSONDecoder()
//        let jsonString = """
//{
//    "message": "institution_calendar list",
//    "status": 1,
//    "status_code": 200,
//    "data": [
//
//        {
//            "_id": "6390b1f6b6505c97e1be9337",
//            "calendar_name": "2025-2026",
//            "end_date": "2026-05-28T00:00:00.000Z",
//            "start_date": "2025-06-08T00:00:00.000Z"
//        },
//        {
//            "_id": "6390af75b6505c8813be8db7",
//            "calendar_name": "2024-2025",
//            "end_date": "2025-05-29T00:00:00.000Z",
//            "start_date": "2024-06-09T00:00:00.000Z"
//        },
//        {
//            "_id": "6390a89cb6505c5cc5be7eff",
//            "calendar_name": "2023-2024",
//            "end_date": "2024-05-30T00:00:00.000Z",
//            "start_date": "2023-06-04T00:00:00.000Z"
//        },
//        {
//            "_id": "629c8a192027d0b0f037b362",
//            "calendar_name": "2022-2023",
//            "end_date": "2023-06-05T00:00:00.000Z",
//            "start_date": "2022-06-05T00:00:00.000Z"
//        },
//        {
//            "_id": "60d05e6d8ff3991b21c9bc2c",
//            "calendar_name": "2021-2022",
//            "end_date": "2022-05-26T00:00:00.000Z",
//            "start_date": "2021-06-20T00:00:00.000Z"
//        }
//    ]
//
//}
//"""
//
//        let jsonData = Data(jsonString.utf8)
//        do {
//            let response = try decoder.decode(AcademicModel.self, from: jsonData)
//
//            return response
//        } catch DecodingError.keyNotFound(let key, let context) {
//            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
//        } catch DecodingError.valueNotFound(let type, let context) {
//            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
//        } catch DecodingError.typeMismatch(let type, let context) {
//            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
//        } catch DecodingError.dataCorrupted(let context) {
//            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
//        } catch let error as NSError {
//            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
//        }
//        return nil
//    }
}
extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        return dateFormatter.string(from: Date())

    }
}

