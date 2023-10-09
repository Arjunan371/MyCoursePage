
import Foundation

class NotificationViewModel {

    var modelData:[NotificationModelData] = []
    var showAcademicDataIndicator: (() -> ())?
    var currentPage = 0
    var data:[String] = ["Notificaton"]
    
    func forNotificationTableView(limit: Int,pageNo: Int,completion:(() -> Void)? = nil) {
        var orginalURL = "https://ecs-dsapi-staging.digivalitsolutions.com/api/v1/digiclass/notification/61a61789b1723a7f23346f70?limit=\(limit)&pageNo=\(pageNo)"
        guard let url = URL(string: orginalURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {return}
        currentPage += 1
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
                    
                    let jasonvalue = try decoder.decode(NotificationModel.self, from: getdata)
                    if self.currentPage == 1 {
                        self.modelData = jasonvalue.data
                    } else {
                        self.modelData.append(contentsOf: jasonvalue.data)
                    }
                   
                    print("self.modelData",try? JSONSerialization.jsonObject(with: getdata))
               
                    DispatchQueue.main.async {
                        completion?()
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
