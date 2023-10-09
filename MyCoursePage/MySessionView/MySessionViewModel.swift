import Foundation

class MySessionViewModel {
    var mySessionCollectionData: [MySessionCollectionData] = []
 //   var mySessionTotalCollectionData: [MySessionCollectionData] = []
    var MySessionTableDatas: [SessionElement] = []
    var showAcademicDataIndicator: (() -> ())?
    var showAcademicIndicator: (() -> ())?
    var selectedTab = 0
    var currentIndex = 0
    var levelList:[String] = []
    var completedSessions: [MySessionTableData] = []
    
    func forMySessionCollectionApi(course:Datum? = nil,completion:(() -> Void)? = nil) {
        var orginalURL = "https://ecs-dsapi-staging.digivalitsolutions.com/api/v1/digiclass/course_session/get-course-session-tab/61a61789b1723a7f23346f70/\(course?.id ?? "")?institutionCalendarId=\(course?.institutionCalendarID ?? "")&programId=\(course?.programID ?? "")&yearNo=\(course?.year ?? "")&levelNo=\(course?.level ?? "")&term=\(course?.term ?? "")"
        if course?.rotation == "yes" {
            orginalURL += "&rotationCount=\(course?.rotationCount ?? 0)"
        }
        guard let url = URL(string: orginalURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {return}
        showAcademicIndicator?()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "AUthorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJEMDAxMiIsImlhdCI6MTY5NjgyNzM2MywiZXhwIjoxNjk2ODYzMzYzfQ._rlWUR6Z-cfyWd4Si-xGnH9KwlIHYxt6m0L_a2X4tUY"
        ]
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {(data,response,error) in
            if error == nil {
                do{
                    let decoder = JSONDecoder()
                    guard let getdata = data else {return}
                    let jasonvalue = try decoder.decode(MySessionCollection.self, from: getdata)
                    self.mySessionCollectionData = jasonvalue.data ?? []
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
    
    func forMySessionTableViewApi(SessionType: String = "",course: Datum? = nil,completion:((MySessionTable) -> Void)? = nil) {
        var orginalURL = "https://ecs-dsapi-staging.digivalitsolutions.com/api/v1/digiclass/course_session/course/61a61789b1723a7f23346f70/\(course?.id ?? "")?institutionCalendarId=\(course?.institutionCalendarID ?? "")&programId=\(course?.programID ?? "")&yearNo=\(course?.year ?? "")&levelNo=\(course?.level ?? "")&term=\(course?.term ?? "")"
        
        if course?.rotation == "yes" {
            orginalURL += "&rotationCount=\(course?.rotationCount ?? 0)"
        }
        orginalURL += "&type=\(SessionType)"
        
        guard let url = URL(string: orginalURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {return}
        showAcademicDataIndicator?()
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
                    
                    let jasonvalue = try decoder.decode(MySessionTable.self, from: getdata)
                        self.MySessionTableDatas = jasonvalue.data?.first?.sessions ?? []
                    print("self.mySessionTableData===>",try? JSONSerialization.jsonObject(with: getdata))
               
                    DispatchQueue.main.async {
                        completion?(jasonvalue)
                    }
                } catch let decodingError {
                    debugPrint(decodingError)
                } catch{
                    print("thanks for giving the error",error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
}
