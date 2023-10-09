

import Foundation

class SessionViewModel {

    var sessionTableData: [SessionModelData] = []
    var showAcademicIndicator: (() -> ())?
    var isSelected = false
    var selectedTab = 0
    
    func indexOf(session: SessionModelData) {
     //   sessionTableData.filter({$0.})
    }
    
    func forSessionApiIntegration(course:Datum? = nil,mySession:SessionElement? = nil,completion:((SessionModel) -> Void)? = nil) {
        var originalUrl = "https://ecs-dsapi-staging.digivalitsolutions.com/api/v1/digiclass/course_session/scheduleDetailsWithSession/61a61789b1723a7f23346f70?institutionCalendarId=\(course?.institutionCalendarID ?? "")&programId=\(course?.programID ?? "")&yearNo=\(course?.year ?? "")&levelNo=\(mySession?.schedules?.first?.levelNo ?? "")&courseId=639054ceb6505c32f2be2c5a&term=\(mySession?.schedules?.first?.term ?? "")&type=\(mySession?.schedules?.first?.type ?? "")&sessionId=\(mySession?.sessionID ?? "")&mergedStatus=\(mySession?.schedules?.first?.mergeStatus ?? false)&scheduleId=\(mySession?.scheduleID ?? "")"
        if course?.rotation == "yes" {
            originalUrl += "&rotationCount=\(course?.rotationCount ?? 0)"
        }
        originalUrl += "&userType=student"
        guard let url = URL(string: originalUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {return}
        showAcademicIndicator?()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json; charset=utf-8",
            "_user_id": "61a61789b1723a7f23346f70",
            "_institution_calendar_id": "6390b1f6b6505c97e1be9337",
            "_institution_id": "5e5d0f1a15b4d600173d5692",
            "AUthorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJEMDAxMiIsImlhdCI6MTY5NjgyNzM2MywiZXhwIjoxNjk2ODYzMzYzfQ._rlWUR6Z-cfyWd4Si-xGnH9KwlIHYxt6m0L_a2X4tUY"
        ]
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {(data,response,error) in
            if error == nil {
                do{
                    let decoder = JSONDecoder()
                    guard let getdata = data else {return}
                    let jasonvalue = try decoder.decode(SessionModel.self, from: getdata)
                    self.sessionTableData = jasonvalue.data ?? []
                    print("self.sessionTableData===>",try? JSONSerialization.jsonObject(with: getdata))
                    DispatchQueue.main.async {
                        completion?(jasonvalue)
                        
                    }
                } catch{
                    debugPrint(error)
                    print("thanks for giving the error")
                    DispatchQueue.main.async {
                   //     completion?()
                    }
                }
            }
           
        }
        dataTask.resume()
    }
}
